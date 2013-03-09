#!/usr/bin/perl


use strict;

#open F,"cat access_log |" or die "Can not open access_log, $!\n";

my (%ip,%host,%time,%url_to,%server_resp,$tran_bit,%url_from,%brower_info,%report,$min,$hour);

##For Apache
#$1=访问的目标站点，$2=IP地址，$3=时间，$4=请求的地址，$5=服务器相应,$6=传输字节,$7=访问来源，$8=浏览器信息
#my $split_log = qr{^([0-9a-zA-Z.-]+)\s+([0-9.]+)\s+-\s+-\s+\[([^]]+)\]\s+"(?:[^"]+)"\s+(?:\d+)\s+(?:\d+)\s+"(?:[^"]+)"\s+"(?:[^"]+)"};
##For NGINX
#$1=IP地址，$2=时间，$3=请求地址，$4=服务器相应，$5=传输字节, $6=访问呢来源，$7=浏览器信息
#121.30.205.117 - - [16/Jul/2009:10:23:35 +0800] "GET /themes/mbb_2.0/images/widget.css HTTP/1.1" 304 0 "http://www.mbaobao.com/" "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; QQDownload 1.7; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30618; CIBA)"
my $split_log = qr{^([0-9.]+)\s+-\s+-\s+\[([^]]+)\]\s+"(?:[^"]+)"\s+(?:\d+)\s+(\d+)\s+"(?:[^"]+)"\s+"(?:[^"]+)"};
my $get_hour_min = qr{(?<=2012:)(\d+):(\d+):(?:\d+)(?=\s+\+\d+)};

sub top {
    my $num = shift;
    my $key = shift;
    my $value = shift;
    my $top = shift;
    #print "$num,$key,$value,$top\n";
    for(my $i=0;$i<$num;$i++){
        #print "DEBUG,$i: $top->{value}->[$i],$value\n" if ($num == 11);
        if ($value > $top->{value}->[$i]) {
            #print "DEBUG,!!$value is biggger\n" if ($num == 11);
            for (my $ii=$num;$ii>$i;$ii--){
                #print "DEBUG move $ii to $ii+1\n" if ($num == 11);
                    $top->{key}->[$ii] = $top->{key}->[$ii-1];
                    $top->{value}->[$ii] = $top->{value}->[$ii-1];
            }
            #print "DEBUG,set $i=$value,it's bigger\n";
            $top->{key}->[$i] = $key;
            $top->{value}->[$i] = $value;
            last;
        }
        next;
    }
    return $top;
}

sub max {
    my $num = shift;
    my $comm = shift;
    my $ref = shift;
    my $top = {};
    $top->{key} = [];
    $top->{value} = [];
    foreach my $key (keys %{$ref}) {
        #print "$key = $ref->{$key}\n" if ($comm eq 'time');
        #print "DEBUG $key = $ref->{$key} \n";
        $top = top($num,$key,$ref->{$key},$top);
    }
    $report{$comm} = $top;
    my ($p_key,$p_value);
    print "--------------------------------------------------------\n";#$comm top $num list:\n";
#    format STDOUT_TOP =
#Name                                               Count
#--------------------------------------------------------
#.

format STDOUT = 
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   @>>>>>>>
$p_key                                          ,$p_value
.
    for (my $i=0;$i<$num;$i++){
            $p_key = $report{$comm}->{key}->[$i];
            $p_value = $report{$comm}->{value}->[$i];
            write;
    }
}

while (my $line = <STDIN>){
    #print $line;
    chomp $line;
    if ($line =~ /$split_log/){
        #print "$1\n$2\n$3\n$4\n$5\n$6\n$7\n$8\n\n\n";
        #$host{$1}++;
        $ip{$1}++;
        #print "$1=$host{$1}\n$2=$ip{$2}\n";
        my $time = $2;
        $tran_bit += $3;
        #$time{$1}++ if ($time =~ /$get_hour/);
        #print "time($1)=$time{$1}\n"
        my ($min_tmp,$hour_tmp);
        if ($time =~ /$get_hour_min/) {
            #$hour_tmp = $1;
            $min_tmp = $2;
        }
        $min = $min_tmp unless ($min);
        #print "$min:$min_tmp\n";
	if ($min == 59) {
		$min = -1;
	} elsif ($min == 58) {
		$min = -2;
	#} elsif ($min == 57) {
	#	$min = -3;
	}
        if (($min+2) == $min_tmp) {
#        if ($min != $min_tmp) {
            print "\n[$time] 2min Report:\n";
            max('10','ip',\%ip);
            #max('11','host',\%host);
            #max('24','time',\%time);
            print '2min Byte stat:   ' . $tran_bit/1024/1024 . "m\n"; 
            $tran_bit = 0;     
            $min = $min_tmp;
            %ip=();
            %host=();
            #sleep 5;
        }
    }
}






