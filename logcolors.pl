#!/usr/bin/perl

use Getopt::Long;
use Term::ANSIColor;

$result = GetOptions ("file=s" => \$filename, # string
                      "colorfile=s" => \$colorFile,
                      "tail" => \$tail,
                      "stdin" => \$stdin); # flag

my $colorMap = loadColorMap($colorFile);

$SIG{INT} = \&resetAndExit;

if($stdin){
  open(LOG, "<&STDIN") || die "Could not open $filename: $!\n";
}else{

    if($tail){
        open(LOG, "tail -f $filename|") || die "Could not tail $filename: $!\n";
    }else{
        open(LOG, "$filename") || die "Could not open $filename: $!\n";
    }

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

sub resetAndExit{
  print colored("\n", "reset");
  exit;
}

sub loadColorMap{
  my $colorFile = shift;
  my $colorMap = {};

  if(-e $colorFile){
      $colorMap = parseColorFile($colorFile);

  }else{
      $colorMap->{'ERROR'} = "red";
      $colorMap->{'Error'} = "red";
      $colorMap->{'DEBUG'} = "cyan";
      $colorMap->{'WARN'} = "yellow";
      #$colorMap->{'JBoss.*Started'} = "cyan blink";
      $colorMap->{'JBoss.*Started'} = "green";
  }

  return $colorMap;
}

sub parseColorFile{
  my $file = shift;
  return {};
}


