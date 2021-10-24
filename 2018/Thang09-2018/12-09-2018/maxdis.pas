type    bignum=array[1..2] of int64;

const   ginp='maxdis.inp';
        gout='maxdis.out';
        maxn=100010;
        mb=2;
        g1:bignum =(0,1);
        oo:bignum =(1844674,4073709551616);
        bbase:bignum =(922337,2036854775808);
        base=round(1e13);

var     n:longint;
        l,r,res,kres:bignum;
        a:array[0..maxn] of bignum;

function cmp(x,y:bignum):boolean; inline;
var     i:longint;
begin
        for i:=1 to mb do
                if x[i]<y[i] then exit(true) else
                if x[i]>y[i] then exit(false);
        exit(false);
end;

function cmp2(x,y:bignum):boolean; inline;
var     i:longint;
begin
        for i:=1 to mb do
                if x[i]<y[i] then exit(true) else
                if x[i]>y[i] then exit(false);
        exit(true);
end;

function plus(x,y:bignum):bignum;
var     i,rem:longint;
begin
        rem:=0;
        for i:=mb downto 1 do
        begin
                plus[i]:=x[i]+y[i]+rem;
                if plus[i]<base then rem:=0 else
                begin
                        rem:=1;
                        dec(plus[i],base);
                end;
        end;
end;

function minus(x,y:bignum):bignum;
var     i,rem:longint;
begin
        rem:=0;
        for i:=mb downto 1 do
        begin
                minus[i]:=x[i]-y[i]-rem;
                if minus[i]>=0 then rem:=0 else
                begin
                        rem:=1;
                        inc(minus[i],base);
                end;
        end;
end;

function div2(x:bignum):bignum;
var     i,rem:longint;
begin
        rem:=0;
        for i:=1 to mb do
        begin
                div2[i]:=(x[i]+int64(rem)*base) div 2;
                if x[i] mod 2=0 then rem:=0 else rem:=1;
        end;
end;

function divm2(x:bignum):bignum;
var     i,rem:longint;
begin
        rem:=0;
        for i:=1 to mb do
        begin
                divm2[i]:=(x[i]+int64(rem)*base) div 2;
                if x[i] mod 2=0 then rem:=0 else rem:=1;
        end;
        if rem=1 then divm2:=plus(divm2,g1);
end;

procedure cvt(var x:bignum; y:int64);
begin
        if y<0 then
        begin
                x[1]:=y div base;
                y:=-(y-x[1]*base); x[1]:=-x[1];
                x[2]:=y mod base; x[2]:=(x[2]+base) mod base;
                x:=minus(bbase,x);
        end else
        begin
                x[1]:=y div base; x[2]:=y mod base;
                x:=plus(bbase,x);
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tmp:bignum;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while cmp(a[i],t) do inc(i);
                while cmp(t,a[j]) do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

procedure enter;
var     i:longint;
        ll,rr,x:int64;
begin
        readln(n,ll,rr);
        cvt(l,ll); cvt(r,rr);
        for i:=1 to n do
        begin
                read(x); cvt(a[i],x);
        end;
        sort(1,n);
end;

procedure process;
var     i:longint;
        tmp,tmp2,kc:bignum;
        tt:string[14];
begin
        kres:=oo; res:=l;
        for i:=1 to n do
        begin
                if cmp(l,a[i]) then tmp:=minus(a[i],l) else tmp:=minus(l,a[i]);
                if cmp(tmp,kres) then kres:=tmp;
        end;
        kc:=oo;
        for i:=1 to n do
        begin
                if cmp(r,a[i]) then tmp:=minus(a[i],r) else tmp:=minus(r,a[i]);
                if cmp(tmp,kc) then kc:=tmp;
        end;
        if cmp2(kres,kc) then
        begin
                kres:=kc; res:=r;
        end;
        for i:=2 to n do
        begin
                kc:=div2(minus(a[i],a[i-1])); tmp:=div2(plus(a[i],a[i-1])); tmp2:=divm2(plus(a[i],a[i-1]));
                if cmp2(kres,kc) then
                begin
                        if (cmp2(l,tmp)) and (cmp2(tmp,r)) then
                        begin
                                kres:=kc; res:=tmp;
                        end;
                        if (cmp2(l,tmp2)) and (cmp2(tmp2,r)) then
                        begin
                                kres:=kc; res:=tmp2;
                        end;
                end;
        end;
        if cmp2(bbase,res) then res:=minus(res,bbase) else
        begin
                write('-'); res:=minus(bbase,res);
        end;
        if res[1]=0 then write(res[2]) else
        begin
                write(res[1]); str(res[2],tt);
                while length(tt)<13 do tt:='0'+tt;
                write(tt);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
