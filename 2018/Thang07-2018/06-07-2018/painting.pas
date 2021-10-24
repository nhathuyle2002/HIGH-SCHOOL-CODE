const   ginp='painting.inp';
        gout='painting.out';
        base=10007;
        maxn=100010;
        maxk=21;

var     n,q,k,all,cou,sum:longint;
        a,b,leave:array[0..maxn] of longint;
        d:array[0..4*maxn] of longint;
        f:array[0..4*maxn,0..maxk] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m,j,jj,id1,id2:longint;
begin
        d[id]:=r-l+1;
        if l=r then
        begin
                leave[l]:=id;
                f[id,0]:=b[l];
                f[id,1]:=a[l];
                exit;
        end;
        m:=(l+r) shr 1;
        id1:=id*2; id2:=id*2+1;
        build(id1,l,m);
        build(id2,m+1,r);
        for j:=0 to min(k,d[id]) do
                for jj:=0 to j do
                        f[id,j]:=(f[id,j]+f[id1,jj]*f[id2,j-jj]) mod base;
end;

procedure enter;
var     i,j:longint;
begin
        readln(n,k); dec(k);
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=a[i] mod base;
        end; readln;
        for i:=1 to n do
        begin
                read(b[i]);
                b[i]:=b[i] mod base;
        end; readln;
        build(1,1,n);
        all:=1; cou:=0;
        for i:=1 to n do
                if (a[i]+b[i]) mod base=0 then inc(cou)
                else all:=all*(a[i]+b[i]) mod base;
end;

function pow(a,b:longint):longint;
var     c:longint;
begin
        if b=0 then exit(1);
        c:=pow(a,b shr 1);
        pow:=c*c mod base;
        if b and 1=1 then pow:=pow*a mod base;
end;

procedure update(id:longint);
var     j,jj,id1,id2:longint;
begin
        if id<1 then exit;
        id1:=id*2; id2:=id*2+1;
        for j:=0 to min(k,d[id]) do
                for jj:=0 to j do
                        f[id,j]:=(f[id,j]+f[id1,jj]*f[id2,j-jj]) mod base;
        update(id shr 1);
end;

procedure process;
var     t,v,j,x,y:longint;
begin
        readln(q);
        for t:=1 to q do
        begin
                readln(v,x,y);
                x:=x mod base; y:=y mod base;
                if (a[v]+b[v]) mod base=0 then dec(cou)
                else all:=all*pow(a[v]+b[v],base-2) mod base;
                if (x+y) mod base=0 then inc(cou)
                else all:=all*pow(x+y,base-2) mod base;
                a[v]:=x;b[v]:=y;
                f[leave[v],0]:=x;f[leave[v],1]:=y;
                update(leave[v] shr 1);
                sum:=0;
                for j:=0 to k do
                        sum:=(sum+f[1,j]) mod base;
                if cou=0 then writeln((all-sum+2*base) mod base)
                else writeln((sum+base) mod base);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
