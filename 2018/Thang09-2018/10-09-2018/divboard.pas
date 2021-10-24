const   ginp='divboard.inp';
        gout='divboard.out';
        maxn=1010;

type    compressed= record ma,mi:longint; end;

var     m,n,res,cou:longint;
        s:array[0..maxn,0..maxn] of longint;
        a,b:array[0..maxn] of compressed;

function min(x,y:longint):longint; inline;
begin
        if x<y then min:=x else min:=y;
end;

function max(x,y:longint):longint; inline;
begin
        if x>y then max:=x else max:=y;
end;

procedure sort(l,r:longint; var d:array of compressed);
var     i,j,t:longint;
        tmp:compressed;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l].ma;
        repeat
                while d[i].ma<t do inc(i);
                while d[j].ma>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d); sort(i,r,d);
end;

function calc(i,j,i0,j0:longint):longint; inline;
begin
        calc:=s[i,j]-s[i0-1,j]-s[i,j0-1]+s[i0-1,j0-1];
end;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(s[i,j]);
                        s[i,j]:=s[i,j]+s[i-1,j]+s[i,j-1]-s[i-1,j-1];
                end;
                readln;
        end;
end;

procedure process;
var     i,j,jj,gmin:longint;
begin
        res:=trunc(1e9)+100;
        for i:=1 to m-1 do
        begin
                for j:=1 to n-1 do
                begin
                        a[j].ma:=max(calc(i,j,1,1),calc(i,n,1,j+1));
                        a[j].mi:=min(calc(i,j,1,1),calc(i,n,1,j+1));
                        b[j].ma:=max(calc(m,j,i+1,1),calc(m,n,i+1,j+1));
                        b[j].mi:=min(calc(m,j,i+1,1),calc(m,n,i+1,j+1));
                end;
                sort(1,n-1,a); sort(1,n-1,b);
                jj:=1; gmin:=-1;
                for j:=1 to n-1 do
                begin
                        while (jj<=n-1) and (b[jj].ma<=a[j].ma) do
                        begin
                                gmin:=max(gmin,b[jj].mi);
                                inc(jj);
                        end;
                        if gmin>-1 then res:=min(res,a[j].ma-min(gmin,a[j].mi));
                end;
                jj:=1; gmin:=-1;
                for j:=1 to n-1 do
                begin
                        while (jj<=n-1) and (a[jj].ma<=b[j].ma) do
                        begin
                                gmin:=max(gmin,a[jj].mi);
                                inc(jj);
                        end;
                        if gmin>-1 then res:=min(res,b[j].ma-min(gmin,b[j].mi));
                end;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
