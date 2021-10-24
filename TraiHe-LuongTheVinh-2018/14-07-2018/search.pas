const   ginp='search.inp';
        gout='search.out';
        oo=trunc(1e6);

var     m,n,p,ca,cb,res:longint;
        a,b,c,d,dd:array[0..100010] of longint;

procedure sort(l,r:longint;var q:array of longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while q[i]<t do inc(i);
                while q[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=q[i];q[i]:=q[j];q[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,q);sort(i,r,q);
end;

procedure enter;
var     i,mm:longint;
begin
        readln(m,n,p);
        for i:=1 to m do read(a[i]);readln;
        sort(1,m,a);
        mm:=1;
        for i:=2 to m do
                if a[i]>a[i-1] then
                begin
                        inc(mm);
                        a[mm]:=a[i];
                end;
        for i:=1 to n do read(b[i]);readln;
        for i:=1 to p do read(c[i]);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,l:longint;
        ok:boolean;
begin
        for i:=1 to m do dd[a[i]]:=1;
        for i:=1 to n do dd[b[i]]:=-1;
        ca:=0;cb:=0;
        l:=1;
        res:=oo;
        for i:=1 to p do
        begin
                if dd[c[i]]=1 then
                begin
                        if d[c[i]]=0 then inc(ca);
                        inc(d[c[i]]);
                end;
                if dd[c[i]]=-1 then inc(cb);
                ok:=false;
                if ca=m then ok:=true;
                repeat
                        if (l>i) or (ca<m) then break;
                        if dd[c[l]]=1 then
                        begin
                                if d[c[l]]=1 then dec(ca);
                                dec(d[c[l]]);
                        end;
                        if dd[c[l]]=-1 then dec(cb);
                        inc(l);
                until false;
                if (ok) and (cb=0) then res:=min(res,i-l+2);
        end;
        if res=oo then write(-1) else write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.


