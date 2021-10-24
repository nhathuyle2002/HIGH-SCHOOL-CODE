const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,maxa,ans:longint;
        h,c,a:array[0..500] of longint;
        f:array[0..401,0..40100] of boolean;

procedure inp;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        maxa:=0;
        for i:=1 to n do
        begin
                readln(gi,h[i],a[i],c[i]);
                if a[i]>maxa then maxa:=a[i];
        end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while t>a[i] do inc(i);
                while t<a[j] do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(h[i],h[j]);
                        swap(c[i],c[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure D_P;
var     i,j,k,tm:longint;
begin
        fillchar(f,sizeof(f),false);
        f[0,0]:=true;
        for i:=1 to n do
                for j:=0 to maxa do
                if f[i-1,j] then
                        for k:=0 to c[i] do
                        if (j+k*h[i]<=maxa) and (j+k*h[i]<=a[i]) then f[i,j+k*h[i]]:=true else break;
        for i:=maxa downto 1 do
                if f[n,i] then
                begin
                        ans:=i;
                        exit;
                end;
end;

procedure outp;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        inp;
        sort(1,n);
        D_P;
        outp;
end.

