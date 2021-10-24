const   ginp='str.inp';
        gout='str.out';
        maxn=300100;

var     gi,go:text;
        a,b,c:ansistring;
        res:longint;

procedure ch(var x:ansistring);
var     i:longint;
begin
        for i:=1 to length(x) do
                if x[i]>'Z' then x[i]:=chr(ord(x[i])-32);
end;

procedure input;
begin
        readln(gi,a);ch(a);
        readln(gi,b);ch(b);
        read(gi,c);ch(c);
        res:=length(a)+length(b)+length(c);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function noiz(g,h:ansistring):ansistring;
var     i,n,l,r,tl,m:longint;
        k:ansistring;
        z:array[0..maxn] of longint;
begin
        k:=h+'*'+g;
        n:=length(k);
        l:=1;r:=1;
        tl:=0;
        fillchar(z,sizeof(z),0);
        for i:=2 to n do
        begin
                if i<=r then z[i]:=min(r-i+1,z[i-l+1]);
                while (i+z[i]<=n) and (k[i+z[i]]=k[1+z[i]]) do inc(z[i]);
                if r<i+z[i]-1 then
                begin
                        l:=i;r:=i+z[i]-1;
                end;
                if z[i]=n-i+1 then
                begin
                        tl:=z[i];
                        break;
                end;
        end;
        noiz:='';
        noiz:=g;m:=length(h);
        for i:=tl+1 to m do
                noiz:=noiz+h[i];
end;

procedure pro(d,e,f:ansistring);
begin
        d:=noiz(d,e);
        d:=noiz(d,f);
        res:=min(res,length(d));
end;

procedure main;
begin
        pro(a,b,c);
        pro(a,c,b);
        pro(b,a,c);
        pro(b,c,a);
        pro(c,a,b);
        pro(c,b,a);
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.


