type    bignum= array[1..2] of int64;

const   ginp='ss.inp';
        gout='ss.out';
        base=round(1e18);

var     n,s:longint;
        f,sum:array[0..100010] of bignum;
        c,m:array[0..501] of longint;

procedure enter;
var     i:longint;
begin
        readln(s,n);
        for i:=1 to n do readln(c[i],m[i]);
end;

operator + (a,b:bignum) c:bignum;
begin
        c[2]:=a[2]+b[2];
        if c[2]>=base then
        begin
                c[2]:=c[2]-base;
                c[1]:=1;
        end else c[1]:=0;
        c[1]:=c[1]+a[1]+b[1];
end;

operator - (a,b:bignum) c:bignum;
begin
        c[2]:=a[2]-b[2];
        if c[2]<0 then
        begin
                c[2]:=c[2]+base;
                c[1]:=1;
        end else c[1]:=0;
        c[1]:=-c[1]+a[1]-b[1];
end;

procedure process;
var     i,j:longint;
        ss:string[19];
begin
        f[0,2]:=1;
        sum[0,2]:=1;
        for i:=1 to n do
        begin
                for j:=1 to s do
                begin
                        sum[j]:=f[j];
                        if j-c[i]>=0 then sum[j]:=sum[j]+sum[j-c[i]];
                        if j-(m[i]+1)*c[i]>=0 then sum[j]:=sum[j]-f[j-(m[i]+1)*c[i]];
                end;
                for j:=1 to s do
                begin
                        f[j]:=sum[j];
                        sum[j,1]:=0;sum[j,2]:=0;
                end;
        end;
        if (f[s,1]=0) and (f[s,2]=0) then write(0) else
        begin
                if f[s,1]>0 then j:=1 else j:=2;
                write(f[s,j]);
                if j=1 then
                begin
                        str(f[s,2],ss);
                        while length(ss)<18 do ss:='0'+ss;
                        write(ss);
                end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
