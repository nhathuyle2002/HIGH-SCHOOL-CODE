const   ginp='triangle.inp';
        gout='triangle.out';

var     gi,go:text;
        n:longint;
        sum:int64;
        a,f,ff:array[0..1111,0..1111] of int64;
        d:array[0..1111,0..1111] of boolean;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
                for j:=1 to i do
                begin
                        read(gi,a[i,j]);
                        f[i,j]:=a[i,j];
                end;
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure atk(i,j:longint);
var     tm1,tm2:int64;
        k:longint;
begin
        if d[i,j]=false then exit;
        d[i,j]:=false;
        if i=n then exit;

        tm1:=(f[i,j]-f[i+2,j+2]-f[n,j])*(n-i);
        tm1:=tm1+a[i,j]+a[n,j]+(f[i,j]-f[i+1,j+1]-a[i,j]-a[n,j])*2;

        tm2:=(f[i,j]-f[i+2,j]-f[n,n-i+j])*(n-i);
        tm2:=tm2+a[i,j]+a[n,n-i+j]+(f[i,j]-f[i+1,j]-a[i,j]-a[n,n-i+j])*2;

        atk(i+1,j);atk(i+1,j+1);
        ff[i,j]:=min(ff[i+1,j]+tm2,ff[i+1,j+1]+tm1);
end;

procedure output;
var     i,j:longint;
begin
        for i:=n-1 downto 1 do
                for j:=1 to i do
                        f[i,j]:=f[i+1,j]+f[i+1,j+1]+f[i,j]-f[i+2,j+1];
        fillchar(d,sizeof(d),true);
        atk(1,1);
        write(go,ff[1,1]);
        close(gi);close(go);
end;

begin
        input;
        output;
end.












