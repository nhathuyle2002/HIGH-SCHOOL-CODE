const   ginp='qprofit.inp';
        gout='qprofit.out';
        maxn=50000;

var     gi,go:text;
        a,t:array[0..200001] of int64;
        d:array[0..50001] of boolean;
        n:longint;

procedure sangnt;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),true);
        d[0]:=false;d[1]:=false;
        for i:=2 to trunc(sqrt(maxn)) do
                if d[i] then
                        for j:=2 to (maxn div i) do
                                d[i*j]:=false;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                if (a[i]>0) and (d[i]) then a[i]:=0;
        end;
end;

procedure build(l,r,k:longint);
var     m:longint;
begin
        if l=r then
        begin
                t[k]:=a[l];
                exit;
        end
        else
        begin
                m:=(l+r) div 2;
                build(l,m,k*2);
                build(m+1,r,k*2+1);
                t[k]:=t[k*2]+t[k*2+1];
        end;
end;

function sum(l,r,d,c,k:longint):int64;
var     m:longint;
begin
        if (l=d) and (r=c) then exit(t[k])
        else if (l>c) or (r<d) then exit(0)
        else
        begin
                m:=(l+r) div 2;
                if (c<=m) then sum:=sum(l,m,d,c,k*2)
                else if (d>=m+1) then sum:=sum(m+1,r,d,c,k*2+1)
                else sum:=sum(l,m,d,m,k*2)+sum(m+1,r,m+1,c,k*2+1);
        end;
end;

procedure process;
var     i,x,y,q:longint;
begin
        readln(gi,q);
        for i:=1 to q do
        begin
                readln(gi,x,y);
                writeln(go,sum(1,n,x,y,1));
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        sangnt;
        input;
        build(1,n,1);
        process;
        output;
end.









