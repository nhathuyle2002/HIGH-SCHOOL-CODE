const   ginp='cprime.inp';
        gout='cprime.out';

var     gi,go:text;
        t,n,n2,dem:longint;
        l,r:int64;
        nt:array[0..100000] of longint;
        d:array[0..1000000] of boolean;
        so:array[0..1000000] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(Go,gout);
        reset(Gi);rewrite(go);
        readln(gi,t);
end;

procedure snt;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),true);
        for i:=2 to 1000 do
                if d[i] then
                begin
                        inc(n);
                        nt[n]:=i;
                        for j:=2 to 1000000 div i do d[i*j]:=false;
                end;
        for i:=1001 to 1000000 do
                if d[i] then
                begin
                        inc(n);
                        nt[n]:=i;
                end;
end;

procedure create;
var     i,j,vt:longint;
        tmp:int64;
begin
        for i:=1 to n do
        begin
                tmp:=1;vt:=2;
                for j:=1 to 50 do
                begin
                        tmp:=tmp*nt[i];
                        if tmp>1e12 then break;
                        if j=nt[vt]-1 then
                        begin
                                inc(n2);
                                so[n2]:=tmp;
                                inc(vt);
                        end;
                end;
        end;
end;

procedure sort(d,c:longint);
var     i,j:longint;
        x,tmp:int64;
begin
        i:=d;j:=c;
        x:=so[random(c-d+1)+d];
        repeat
                while x>so[i] do inc(i);
                while x<so[j] do dec(j);
                if i<=j then
                begin
                        tmp:=so[i];
                        so[i]:=so[j];
                        so[j]:=tmp;
                        inc(i);
                        dec(j);
                end;
        until i>j;
        if d<j then sort(d,j);
        if i<c then sort(i,c);
end;

function cnp1(x:int64):longint;
var     d,c,m:longint;
begin
        d:=1;c:=n2;
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if so[m]<x then d:=m else c:=m;
                m:=(d+c) div 2;
        end;
        for m:=d to c do
                if so[m]>=x then exit(m);
end;

function cnp2(x:int64):longint;
var     d,c,m:longint;
begin
        d:=1;c:=n2;
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if so[m]>x then c:=m else d:=m;
                m:=(d+c) div 2;
        end;
        for m:=c downto d do
                if so[m]<=x then exit(m);
end;

procedure tt;
var     k:longint;
begin
        if (r<=1e6) then
                        for k:=l to r do
                                if d[k] then inc(dem);
end;

procedure process;
var     i,k,tmp1,tmp2:longint;
begin
        snt;
        create;
        sort(1,n2);
        for i:=1 to t do
        begin
                readln(gi,l,r);
                dem:=0;
                tt;
                tmp1:=cnp1(l);
                tmp2:=cnp2(r);
                dem:=dem+(tmp2-tmp1+1);
                writeln(go,dem);
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
