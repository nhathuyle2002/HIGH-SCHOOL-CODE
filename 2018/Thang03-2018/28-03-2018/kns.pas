const   ginp='kns.inp';
        gout='kns.out';

var     gi,go:text;
        n:longint;
        a:array[0..101] of string;

procedure input;
var     i,tm:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,tm);
                str(tm,a[i]);
        end;
end;

function sosanh(x,y:string):boolean;
var     i:longint;
        tmp1,tmp2:string;
begin
        tmp1:=x+y;
        tmp2:=y+x;
        for i:=1 to length(tmp1) do
        begin
                if tmp1[i]<tmp2[i] then exit(true);
                if tmp1[i]>tmp2[i] then exit(false);
        end;
        exit(false);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        tm,tt:string;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=a[random(r-l+1)+l];
        repeat
                while sosanh(a[i],tm) do inc(i);
                while sosanh(tm,a[j]) do dec(j);
                if i<=j then
                begin
                        tt:=a[i];
                        a[i]:=a[j];
                        a[j]:=tt;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure output;
var     i:longint;
begin
        for i:=n downto 1 do write(go,a[i]);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        output;
end.



