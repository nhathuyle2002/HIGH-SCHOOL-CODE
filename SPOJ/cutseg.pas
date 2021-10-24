const   ginp='ss.inp';
        gout='ss.out';
        maxn=201;

var     n:longint;
        a:ansistring;
        pos:array[0..maxn,'0'..'9'] of longint;
        f:array[0..maxn,0..maxn,0..maxn] of longint;

function max(x,y:longint):longint;
begin
        if x>y then max:=x else max:=y;
end;

procedure enter;
var     i:longint;
        x:char;
        p:array['0'..'9'] of longint;
begin
        readln(n);
        read(a);
        fillchar(p,sizeof(p),0);
        for i:=n downto 1 do
        begin
                for x:='0' to '9' do pos[i,x]:=p[x];
                p[a[i]]:=i;
        end;
end;

function calc(l,r,k:longint):longint;
var     i:longint;
begin
        if l>r then exit(0);
        if f[l,r,k]>0 then exit(f[l,r,k]);
        if l=r then exit(sqr(k+1));
        calc:=0;
        for i:=l+1 to r do
                if a[i]<>a[l] then
                begin
                        calc:=sqr(i-l+k)+calc(i,r,0);
                        break;
                end;
        i:=pos[l,a[l]];
        while (i>0) and (i<=r) do
        begin
                calc:=max(calc,calc(l+1,i-1,0)+calc(i,r,k+1));
                i:=pos[i,a[i]];
        end;
        f[l,r,k]:=calc;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        write(calc(1,n,0));
        close(input);close(output);
end.
