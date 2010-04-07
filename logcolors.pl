#!/usr/bin/perl

use Getopt::Long;
use Term::ANSIColor;

$result = GetOptions ("file=s" => \$filename, # string
                      "colorfile=s" => \$colorFile,
                      "tail" => \$tail); # flag

my $colorMap = loadColorMap($colorFile);


if($tail){
    open(LOG, "tail -f $filename|") || die "Could not tail $filename: $!\n";
}else{
    open(LOG, "$filename") || die "Could not open $filename: $!\n";
}

while($line = <LOG>){
    my $matched = 0;
    foreach $regex (keys(%$colorMap)){
        if($line =~ /$regex/){
            print colored($line, $colorMap->{$regex});
            $matched = 1;
            last;
        }
    }

    unless($matched){
      print $line;
    }
}

sub loadColorMap{
  my $colorFile = shift;
  my $colorMap = {};

  if(-e $colorFile){
      $colorMap = parseColorFile($colorFile);

  }else{
      $colorMap->{'ERROR'} = "red";
      $colorMap->{'DEBUG'} = "green";
      $colorMap->{'WARN'} = "yellow";
  }

  return $colorMap;
}

sub parseColorFile{
  my $file = shift;
  return {};
}


