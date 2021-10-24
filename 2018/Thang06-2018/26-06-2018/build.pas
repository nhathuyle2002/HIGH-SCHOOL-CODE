const   ginp='build.inp';
        gout='build.out';

var     gi,go:text;
        n,k,a,b,c:longint;
        v,w:array[0..100010] of longint;
        f:array[0..100010,0..1001] of longint;

procedure input;
var     i,td:longint;
        d:array[-100010..100010] of longint;
        s:ansistring;
begin
        readln(gi,a,b,c);
        readln(gi,n,k);
        read(gi,s);
        for i:=-n to n do d[i]:=-1;
        d[0]:=0;td:=0;
        for i:=1 to n do
        begin
                if s[i]='R' then w[i]:=a else
                begin
                        w[i]:=b;
                        if s[i]='D' then dec(td) else inc(td);
                end;
                f[i,0]:=f[i-1,0]+w[i];
                if (d[td]<>i-1) and (d[td]<>-1) then v[i]:=d[td] else v[i]:=-1;
                d[td]:=i;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        for j:=1 to k do
                for i:=1 to n do
                        if v[i]=-1 then f[i,j]:=f[i-1,j]+w[i] else
                        f[i,j]:=min(f[i-1,j]+w[i],f[v[i],j-1]+(i-v[i])*c);
        write(go,f[n,k]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
