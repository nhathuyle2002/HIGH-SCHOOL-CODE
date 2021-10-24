const   ginp='xn.inp';
        gout='xn.out';

var     gi,go:text;
        n,m,k:longint;
        a:array[0..2001,0..11] of longint;
        f,ou:array[0..2001] of longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,k);
        for i:=1 to n do
        begin
                for j:=1 to m do read(gi,a[i,j]);
                readln(gi);
        end;
end;

function sosanh(h1,h2:longint):boolean;
var     i:longint;
begin
        for i:=1 to m do
                if a[h1,i]>a[h2,i] then exit(false)
                else if a[h1,i]<a[h2,i] then exit(true);
        exit(false);
end;

procedure swap(h1,h2:longint);
var     x:array[0..11] of longint;
begin
        x:=a[h1];
        a[h1]:=a[h2];
        a[h2]:=x;
end;

procedure sort(l,r:longint);
var     i,j,x:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=random(r-l+1)+l;
        repeat
                while sosanh(i,x) do inc(i);
                while sosanh(x,j) do dec(j);
                if i<=j then
                begin
                        swap(i,j);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);
        sort(i,r);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function sosanh2(h1,h2:longint):boolean;
var     i:longint;
begin
        for i:=1 to m do
                if a[h1,i]>a[h2,i] then exit(false);
        exit(true);
end;

procedure process;
var     i,j,ans,vt:longint;
begin
        for i:=1 to n do
                for j:=i-1 downto 1 do
                        if sosanh2(j,i) then f[i]:=max(f[i],f[j]+1);
        ans:=0;
        for i:=1 to n do ans:=max(ans,f[i]);
        if ans>k then
        begin
                write(go,-1);
                exit;
        end;
        for i:=1 to n do
                if f[i]<>0 then inc(ou[f[i]]) else inc(ou[k]);
        vt:=0;
        for i:=1 to k do
        begin
                while (ou[vt]<=1) and (vt<k) do inc(vt);
                if ou[i]=0 then
                begin
                        dec(ou[vt]);
                        inc(ou[i]);
                end;
        end;
        for i:=1 to k do writeln(go,ou[i]);
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.





















