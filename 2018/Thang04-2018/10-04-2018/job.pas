const   ginp='job.inp';
        gout='job.out';

var     gi,go:text;
        m,n,ans:longint;
        a:array[0..1001,0..1001] of longint;

procedure input;
var     i,j:longint;
        s:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for j:=1 to m do
        begin
                readln(gi,s);
                for i:=1 to n do
                        a[i,j]:=ord(s[i])-96;
        end;
end;

function sosanh(x,y:array of longint):boolean;
var     i:longint;
begin
        for i:=m downto 1 do
                if x[i]<y[i] then exit(true)
                else if x[i]>y[i] then exit(false);
        exit(false);
end;

procedure sort(l,r:longint);
var     i,j,k,tm:longint;
        t:array[0..1001] of longint;
begin
        if l>=r then exit;
        t:=a[random(r-l+1)+l];
        i:=l;j:=r;
        repeat
                while sosanh(a[i],t) do inc(i);
                while sosanh(t,a[j]) do dec(j);
                if i<=j then
                begin
                        for k:=1 to m do
                        begin
                                tm:=a[i,k];
                                a[i,k]:=a[j,k];
                                a[j,k]:=tm;
                        end;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,j,tm:longint;
begin
        ans:=m-1;
        for i:=1 to n-1 do
        begin
                for j:=m downto 1 do
                        if a[i,j]<>a[i+1,j] then break;
                if ans>j-1 then ans:=j-1;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.










