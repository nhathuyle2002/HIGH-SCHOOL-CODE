const   ginp='mountain.inp';
        gout='mountain.out';
        maxn=30010;
        oo=trunc(1e15);

var     n,n0:longint;
        res:int64;
        nt,h:array[0..maxn] of longint;
        s1,s2,f1,f2:array[0..maxn] of int64;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(h[i]);
        for i:=1 to n do
        begin
                s1[i]:=s1[i-1]+h[i];
                f1[i]:=f1[i-1]+s1[i-1];
        end;
        for i:=n downto 1 do
        begin
                s2[i]:=s2[i+1]+h[i];
                f2[i]:=f2[i+1]+s2[i+1];
        end;
end;

procedure create;
var     i,j:longint;
        d:array[0..maxn] of boolean;
begin
        n0:=0;
        fillchar(d,sizeof(d),true);
        for i:=2 to n-1 do
                if d[i] then
                begin
                        inc(n0);nt[n0]:=i;
                        for j:=i to (n-1) div i do d[i*j]:=false;
                end;
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function calc(i,l,r:longint):int64;
begin
        if (i=l) and (i=r) then exit(0) else
        if i=l then calc:=f2[i]-f2[r+1]-s2[r+1]*(r-i+1) else
        if i=r then calc:=f1[i]-f1[l-1]-s1[l-1]*(i-l+1) else
        calc:=f1[i]-f1[l-1]-s1[l-1]*(i-l+1)+f2[i]-f2[r+1]-s2[r+1]*(r-i+1);
end;

procedure process;
var     i,j,j1,j2,j3,m,k:longint;
begin
        res:=oo;
        for i:=1 to n do
        begin
                if n<4 then res:=min(res,calc(i,1,n));
                for k:=1 to n0 do
                if i+nt[k]>n then break else
                if (k>2) and (nt[k]-nt[k-1]=2) then
                begin
                        j1:=i+nt[k-1]; j2:=i+nt[k];
                        m:=(i+j1) shr 1;
                        res:=min(res,calc(i,1,m)+calc(j1,m+1,j1+1)+calc(j2,j2,n));
                        j1:=i+2; //j2:=i+nt[k];
                        m:=(j1+j2) shr 1;
                        res:=min(res,calc(i,1,i+1)+calc(j1,j1,m)+calc(j2,m+1,n));
                end else
                begin
                        j:=i+nt[k];
                        m:=(i+j) shr 1;
                        res:=min(res,calc(i,1,m)+calc(j,m+1,n));
                end;
                if i+7<=n then
                begin
                        j1:=i+2; j2:=i+5; j3:=i+7;
                        res:=min(res,calc(i,1,i+1)+calc(j1,j1,j1+1)+calc(j2,j1+2,j2+1)+calc(j3,j3,n));
                end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        create;
        process;
        write(res);
        close(input);close(output);
end.



