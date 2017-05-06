#!/usr/bin/perl
use strict;
use warnings;
use feature ':5.10';

use File::Basename qw/dirname/;
use File::Path qw/mkpath/;
use Cwd qw/getcwd/;

# main
if ($#ARGV == -1 or $#ARGV > 2) {
    usage() and exit 1;
}

my %config = parse_config( (dirname $0) . '/' .'dotfiles_config');
my %link_table = generate_table(\%config);

my $dry_run = ''; # false
if ($#ARGV == 1 and $ARGV[1] eq '--dry') {
    $dry_run = 'true';
}

# Subcommand
if ($ARGV[0] eq 'link') {
    links(\%link_table, $dry_run);
} elsif ($ARGV[0] eq 'unlink') {
    unlinks(\%link_table, $dry_run);
} elsif ($ARGV[0] eq 'refresh') {
    unlinks(\%link_table, $dry_run);
    links(\%link_table, $dry_run);
} else {
    usage() and exit 1;
}

# main end

sub parse_config {
    my ($config_file) = @_;
    my %config;
    open my $config_fh, '<', $config_file
        or die "ERROR: Can't open $config_file; $!\n";

    while (my $line = readline $config_fh) {
        chomp $line;

        # comment or empty line
        if ($line eq '' or $line =~ /^(?:\s*#.*)|(?:\s+)$/) {
            next;
        } elsif ($line =~ /^\[(.+)\]/) { # [Section]
            my $section = lc $1;

            if ($section eq 'general') {
                %{$config{$section}} = parse_hash(*$config_fh);
            } else {
                my @result = parse_list(*$config_fh);
                if ($section eq 'directory') {
                    @result = map { normalize_dir($_) } @result;
                }
                @{$config{$section}} = @result;
            }
        } else {
            close $config_fh;
            die "ERROR: Syntax error in $config_file\n";
        }
    }

    close $config_fh;
    return %config;
}

sub parse_hash {
    my ($fh) = @_;
    my %kvs;
    while (my $line = readline $fh) {
        chomp $line;
        if ($line eq '') { # section end is empty line
            return %kvs;
        } elsif ($line =~ /^(?:\s*#.*)$/) {
            next;
        } else {
            my ($key, $value) = split /\s*=\s*/, $line, 2;
            $kvs{$key} = $value;
        }
    }

    return %kvs;
}

sub parse_list {
    my ($fh) = @_;
    my @elms;
    while (my $line = readline $fh) {
        chomp $line;
        if ($line eq '') { # section end is empty line
            return @elms;
        } elsif ($line =~ /^(?:\s*#.*)$/) {
            next;
        } else {
            push @elms, $line;
        }
    }

    return @elms;
}

# Add tail slash and expand $HOME
sub normalize_dir {
    my ($dir) = @_;
    if (substr($dir, -1) ne '/') {
        $dir = $dir . '/';
    }

    # FIXME: better way
    my $homedir = $ENV{HOME};
    $dir =~ s/\$HOME/$homedir/g;
    return $dir;
}

sub generate_table {
    my (@config) = @_;
    my %result;

    # directories
    for my $dir (@{$config{directory}}){
        my $entity = getcwd . '/' .  $dir;
        my $root = normalize_dir($config{general}{root});
        my $symlink = $root . prefix_dot($dir);
        $symlink =~ s/\/+$//g; # symlink name doesn't finish with slash(es)
        $result{$entity} = $symlink;
    }

    # files
    my @files = split /\n/, `git ls-files`;
    for my $f (@files){
        if (is_ignore($f) or in_directory($f)) {
            next;
        } else {
            my $entity = getcwd . '/' . $f;
            my $root = normalize_dir($config{general}{root});
            my $symlink = $root . prefix_dot($f);
            $result{$entity} = $symlink;
        }
    }

    return %result;
}

sub is_ignore {
    my ($f) = @_;
    for my $ignore (@{$config{ignore}}){
        # FIXME: smarter way
        if ($f =~ /^$ignore/) {
            return 'true';
        }
    }
    return ''; # false
}

sub in_directory {
    my ($f) = @_;
    for my $dir (@{$config{directory}}){
        # FIXME: smarter way
        if ($f =~ /^$dir/) {
            return 'true';
        }
    }
    return ''; # false
}

sub prefix_dot {
    my ($path) = @_;
    for my $entry (@{$config{prefixdot}}){
        # FIXME: smarter way
       if ($path =~ /^$entry/) {
           return ".$path";
       }
    }

    return $path;
}

sub usage {
    warn "$0 (link|unlink|refresh) [--dry]\n";
    return 'true';
}

sub links {
    my ($link_table, $dry_run) = @_;
    while (my ($entity, $symlink) = each(%link_table)) {

        # if parent directory doesn't exist
        my $parent_dir = dirname $symlink;
        if (!-d $parent_dir) {
            if ($dry_run) {
                print "mkdir $parent_dir\n";
            } else {
                mkpath $parent_dir
                    or die "ERROR: Can't make $parent_dir; $!\n";
            }
        }

        if ($dry_run) {
            print "symlink $entity -> $symlink\n"
        } else {
            symlink $entity,  $symlink
                or warn "WARN: $! (when linking to $symlink)\n";
        }
    }

    return;
}

sub unlinks {
    my ($link_table, $dry_run) = @_;

    while (my ($entity, $symlink) = each(%link_table)) {

        if (-l $symlink ) { # if symbolic link
            # unlink removes normal files too!!!!
            if ($dry_run) {
                print "unlink $symlink\n"
            } else {
                unlink $symlink
                    or warn "WARN: $! (when unlinking to $symlink)\n";
            }
        }

    }
    return;

}

