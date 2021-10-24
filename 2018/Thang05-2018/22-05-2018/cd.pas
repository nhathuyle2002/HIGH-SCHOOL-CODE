const   ginp='cd.inp';
        gout='cd.out';

var     gi,go:text;
        n,w:longint;
        a,d,vt:array[0..201] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,w);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                vt[i]:=i;
        end;
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        tm:=vt[i];vt[i]:=vt[j];vt[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,vtc:longint;
        sum:int64;
begin
        sort(1,n);
        a[n+1]:=maxlongint;
        fillchar(d,sizeof(d),0);
        sum:=0;
        for i:=1 to n+1 do
        begin
                sum:=sum+a[i];
                if sum>2*w then break;
        end;
        vtc:=i;dec(vtc);
        sum:=0;
        for i:=vtc downto 1 do
                if sum+a[i]<=w then
                begin
                        sum:=sum+a[i];
                        d[vt[i]]:=1;
                end;
        sum:=0;
        for i:=vtc downto 1 do
                if (d[vt[i]]=0) and (sum+a[i]<=w) then
                begin
                        sum:=sum+a[i];
                        d[vt[i]]:=2;
                end;
end;

procedure output;
var     i:longint;
begin
        for i:=1 to n do write(go,d[i],' ');
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.









