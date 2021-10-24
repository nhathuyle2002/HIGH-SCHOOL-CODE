const   ginp='dc.inp';
        gout='dc.out';

var     last,m,p:longint;
        res,taxi,bus:int64;
        a,b:array[0..100010] of longint;

procedure enter;
var     i:longint;
begin
        readln(last,m,p,taxi,bus);
        for i:=1 to m do read(a[i]);readln;
        a[0]:=1;inc(m);a[m]:=last;
        for i:=1 to p do read(b[i]);
        b[0]:=1;inc(p);b[p]:=last;
end;

function cnp(x:longint):longint;
var     l,r,mid:longint;
begin
        l:=1;r:=p-1;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if x>=b[mid] then l:=mid+1 else r:=mid;
        end;
        cnp:=l;
end;

function abs(x:longint):longint;
begin
        if x<0 then abs:=-x else abs:=x;
end;

function min(x,y:int64):int64;
begin
        if x<y then min:=x else min:=y;
end;

procedure process;
var     i,ii,it,i0,j0:longint;
        tmp:int64;
begin
        it:=cnp(a[0]);
        for i:=1 to m do
        begin
                tmp:=taxi*abs(a[i]-a[i-1]);
                ii:=cnp(a[i]);
                for j0:=it-1 to it+1 do
                for i0:=ii-1 to ii+1 do
                        if i0<>j0 then
                        tmp:=min(tmp,taxi*abs(a[i-1]-b[j0])+taxi*abs(a[i]-b[i0])+bus);
                it:=ii;
                res:=res+tmp;
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
