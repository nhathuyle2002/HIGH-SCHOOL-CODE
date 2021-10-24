const   ginp='ss.inp';
        gout='ss.out';

type    mang=array[1..6] of longint;

var     gi,go:text;
        n:longint;
        a:array[0..100001] of mang;

function sosanh(x,y:mang):boolean;inline;
var     i:longint;
begin
        for i:=1 to 6 do
        begin
                if x[i]>y[i] then exit(false);
                if x[i]<y[i] then exit(true);
        end;
        exit(false);
end;

procedure input;
var     i,j,k,tmp:longint;
        b:mang;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to 6 do read(gi,a[i,j]);readln(gi);
                b:=a[i];
                for j:=1 to 5 do
                begin
                        tmp:=b[6];
                        for k:=6 downto 2 do b[k]:=b[k-1];
                        b[1]:=tmp;
                        if sosanh(b,a[i]) then a[i]:=b;
                end;
                for j:=1 to 6 do b[j]:=a[i,6-j+1];
                if sosanh(b,a[i]) then a[i]:=b;
                for j:=1 to 5 do
                begin
                        tmp:=b[6];
                        for k:=6 downto 2 do b[k]:=b[k-1];
                        b[1]:=tmp;
                        if sosanh(b,a[i]) then a[i]:=b;
                end;
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:mang;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while sosanh(a[i],t) do inc(i);
                while sosanh(t,a[j]) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,j:longint;
        ok:boolean;
begin
        sort(1,n);
        for i:=2 to n do
        begin
                ok:=true;
                for j:=1 to 6 do
                        if a[i-1,j]<>a[i,j] then ok:=false;
                if ok then break;
        end;
        if ok then write(go,'Twin snowflakes found.')
        else write(go,'No two snowflakes are alike.');
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
