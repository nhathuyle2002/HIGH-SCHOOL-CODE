const   ginp='ss.inp';
        gout='ss.out';
        maxn=1001;

var     gi,go:text;
        f:array[0..maxn,0..4,0..4,0..4] of longint;
        a:array[0..maxn,1..6] of longint;
        n,z0,s0,m0:longint;

procedure input;
var     z,m,s,i,j,k,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        readln(gi,z,s,m,z0,s0,m0);
        for j:=0 to 4 do
                for k:=0 to 4 do
                        for t:=0 to 4 do f[0,j,k,t]:=maxn;
        f[0,z,s,m]:=0;
        for i:=1 to n do
        begin
                for j:=1 to 6 do read(gi,a[i,j]);
                readln(gi);
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure xuli(i,j,k,t:longint);
var     j2,k2,t2:longint;
begin
        f[i,j,k,t]:=f[i-1,j,k,t];
        j2:=j-a[i,4]+a[i,1];
        k2:=k-a[i,5]+a[i,2];
        t2:=t-a[i,6]+a[i,3];
        if (j2>=a[i,1]) and (k2>=a[i,2]) and (t2>=a[i,3])
        and (j2<=4) and (k2<=4) and (t2<=4)
        and ((j2<z0) or (k2<s0) or (t2<m0)) then
        f[i,j,k,t]:=min(f[i,j,k,t],f[i-1,j2,k2,t2]+1);
end;

procedure process;
var     i,j,k,t,j2,k2,t2:longint;
begin
        for i:=1 to n do
        for j:=0 to 4 do
        for k:=0 to 4 do
        for t:=0 to 4 do
                {if (j>=a[i,1]) and (k>=a[i,2]) and (t>=a[i,3]) and (j-a[i,1]+a[i,4]<=z0) and (k-a[i,2]+a[i,5]<=s0) and (t-a[i,3]+a[i,6]<=m0) then
                f[i,j-a[i,1]+a[i,4],k-a[i,2]+a[i,5],t-a[i,3]+a[i,6]]:=min(f[i-1,j-a[i,1],k-a[i,2],t-a[i,3]]+1,f[i,j-a[i,1]+a[i,4],k-a[i,2]+a[i,5],t-a[i,3]+a[i,6]]);}
        begin
                {f[i,j,k,t]:=f[i-1,j,k,t];
                j2:=j-a[i,4]+a[i,1];
                k2:=k-a[i,5]+a[i,2];
                t2:=k-a[i,6]+a[i,3];
                if (j2>=a[i,1]) and (k2>=a[i,2]) and (t2>=a[i,3])
                and (j2<=4) and (k2<=4) and (t2<=4)
                and ((j2<z0) or (k2<s0) or (t2<m0)) then
                        f[i,j,k,t]:=min(f[i,j,k,t],f[i-1,j2,k2,t2]+1);}
                xuli(i,j,k,t);
        end;
end;

procedure output;
var     j,k,t,dem:longint;
        x0:array[0..10000,1..4] of longint;
begin
        dem:=0;
        for j:=z0 to 4 do
                for k:=s0 to 4 do
                        for t:=m0 to 4 do
                                if f[n,j,k,t]<maxn then
                                begin
                                        inc(dem);
                                        x0[dem,1]:=j;
                                        x0[dem,2]:=k;
                                        x0[dem,3]:=t;
                                        x0[dem,4]:=f[n,j,k,t];

                      end;
        if dem=0 then write(go,-1) else
        begin
        writeln(go,dem);
        for j:=1 to dem do
        begin
                for k:=1 to 4 do write(go,x0[j,k],' ');
                writeln(go);
        end;
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.














