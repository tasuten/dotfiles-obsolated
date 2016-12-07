#!/usr/bin/perl
use strict;
use warnings;
use feature ":5.10";

use Data::Dumper;

# main
our %config = parse_config("./dotfiles_config");
print Dumper %config;

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
            @{$config{$section}} = parse_section($section, *CONFIG);
        } else {
            die "Syntax error in $config_file";
        }
    }

    close CONFIG;
    return %config;
}

sub parse_section {
    my ($section, $fh) = @_;
    if ($section eq "general") {
        return parse_hash($fh);
    } else {
        my @result = parse_list($fh);
        if ($section eq "directory") {
            @result = map { normalize_dir($_) } @result;
        }
        return @result;
    }
}

sub parse_hash {
   my ($fh) = @_;
   my %kvs;
    while (my $line = readline $fh) {
        chomp $line;
        if ($line eq "") {
            return %kvs;
            break;
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
            break;
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
   return $dir;
}

