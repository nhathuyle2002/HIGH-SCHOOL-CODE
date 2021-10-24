const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k,sum:longint;
        a:array[0..21,0..21] of longint;
        f:array[0..21,0..21,0..210] of boolean;
        trace:array[0..21,0..21,0..210] of longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,sum,n,k);
        for j:=1 to k do
        begin
                for i:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

procedure trace_back(j:longint);
var     i,s,tm:longint;
        ou:array[0..21] of longint;
begin
        writeln(go,'YES');
        i:=n;s:=sum;
        while i>0 do
        begin
                ou[i]:=a[i,j];
                tm:=j;
                j:=trace[i,j,s];
                s:=s-a[i,tm];
                dec(i);
        end;
        for i:=1 to n do write(go,ou[i],' ');
end;

procedure D_P;
var     i,j,s,j2:longint;
begin
        fillchar(f,sizeof(f),false);
        for i:=1 to k do f[1,i,a[1,i]]:=true;
        for i:=2 to n do
                for j:=1 to k do
                        for j2:=1 to k do
                        if a[i,j]>=a[i-1,j2] then
                                for s:=1 to sum do
                                if s-a[i,j]>0 then
                                if f[i-1,j2,s-a[i,j]] then
                                begin
                                        f[i,j,s]:=true;
                                        trace[i,j,s]:=j2;
                                end;
        for j:=1 to k do
                if f[n,j,sum] then
                begin
                        trace_back(j);
                        exit;
                end;
        write(go,'NO');
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        D_P;
        output;
end.








