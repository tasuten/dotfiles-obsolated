#!/usr/bin/perl
use strict;
use warnings;
use feature ":5.10";

use File::Basename;
use File::Path;
use Cwd;

use Data::Dumper;

# main
our %config = parse_config("./dotfiles_config");
our %link_table = generate_table();
# print Dumper %link_table;
if ($#ARGV == -1 || $#ARGV > 2) {
    usage() and exit 1;
}
our $dry = undef;
if ($#ARGV == 1 && $ARGV[1] eq "--dry") {
    $dry = 'true';
}

if ($ARGV[0] eq "link") {
    links();
} elsif ($ARGV[0] eq "unlink") {
    unlinks();
} elsif ($ARGV[0] eq "refresh") {
    unlinks();
    links();
} else {
    usage() and exit 1;
}


# main end

sub parse_config {
    my %config;
    my ($config_file) = @_;
    open CONFIG, $config_file || die "Can't open $config_file: $!";

    while (my $line = readline CONFIG) {
        chomp $line;
        if ($line =~ /^(?:\s*#.*)|(?:\s+)$/) {
            next;
        } elsif ($line =~ /^\[(.+)\]/) {
            my $section = lc $1;

            if ($section eq "general") {
                %{$config{$section}} = parse_hash(*CONFIG);
            } else {
                my @result = parse_list(*CONFIG);
                if ($section eq "directory") {
                    @result = map { normalize_dir($_) } @result;
                }
                @{$config{$section}} = @result;
            }
        } else {
            die "Syntax error in $config_file";
        }
    }

    close CONFIG;
    return %config;
}

sub parse_hash {
    my ($fh) = @_;
    my %kvs;
    while (my $line = readline $fh) {
        chomp $line;
        if ($line eq "") {
            return %kvs;
        } elsif ($line =~ /^(?:\s*#.*)$/) {
            next;
        } else {
            my ($key, $value) = split /\s*=\s*/, $line, 2;
            $kvs{$key} = $value;
        }
    }
}

sub parse_list {
    my ($fh) = @_;
    my @elms;
    while (my $line = readline $fh) {
        chomp $line;
        if ($line eq "") {
            return @elms;
        } elsif ($line =~ /^(?:\s*#.*)$/) {
            next;
        } else {
            push @elms, $line;
        }
    }
}

sub normalize_dir {
    my ($dir) = @_;
    if (substr($dir, -1) ne "/") {
        $dir = "$dir/";
    }

    my $homedir = $ENV{"HOME"};
    $dir =~ s/\$HOME/$homedir/g;
    return $dir;
}


sub generate_table {
    my %result;

    # directories
    for my $dir (@{$config{directory}}){
        my $entity = getcwd . "/" .  $dir;
        my $root = normalize_dir($config{"general"}{"root"});
        my $symlink = $root . $dir;
        $symlink =~ s/\/+$//g;
        $result{$entity} = $symlink;
    }

    # files
    my @files = split /\n/, `git ls-files`;
    for my $f (@files){
        if (is_ignore($f) || in_directory($f)) {
            next;
        } else {
            my $entity = getcwd . "/" . $f;
            my $root = normalize_dir($config{"general"}{"root"});
            my $symlink = $root . $f;
            $result{$entity} = $symlink;
        }
    }

    return %result;
}

sub is_ignore {
    my ($f) = @_;
    for my $ignore (@{$config{ignore}}){
        if ($f =~ /^$ignore/) {
            return 'true';
        }
    }
    return undef;
}


sub in_directory {
    my ($f) = @_;
    for my $dir (@{$config{directory}}){
        if ($f =~ /^$dir/) {
            return 'true';
        }
    }
    return undef;
}

sub usage {
    print "$0 (link|unlink|refresh) [--dry]\n"
}

sub links {
    while (my ($entity, $symlink) = each(%link_table)) {
        my $parent_dir = dirname($symlink);
        if (!-d $parent_dir ) {
            if ($dry) {
                print "mkdir $parent_dir";
            } else {
            mkpath($parent_dir);
        }
        }
        if ($dry) {
            print "symlink $entity -> $symlink\n"
        } else {
        symlink $entity,  $symlink;
    }
    }
}

sub unlinks {
    while (my ($entity, $symlink) = each(%link_table)) {
        if (-l $symlink ) {
            # unlinkは通常ファイルも消し飛ばすので注意
            if ($dry) {
                print "unlink $symlink\n"
            } else {
            unlink $symlink;
        }
        }
    }
}

