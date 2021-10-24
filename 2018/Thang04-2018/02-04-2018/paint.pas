const   ginp='paint.inp';
        gout='paint.out';

var     gi,go:text;
        m,n,r,c,ss,ans:longint;
        a,b,sum,ha,hb:array[0..2001,0..2001] of longint;

procedure input;
var     i,j:longint;
        x:char;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,r,c,m,n);
        for i:=1 to r do
        begin
                for j:=1 to c do
                begin
                        read(gi,x);
                        if x='o' then b[i,j]:=1 else b[i,j]:=2;
                        ss:=ss+b[i,j];
                        if b[i-1,j]=b[i,j] then hb[i,j]:=hb[i-1,j]+1 else hb[i,j]:=1;
                end;
                readln(gi);
        end;
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(gi,x);
                        if x='o' then a[i,j]:=1 else a[i,j]:=2;
                        sum[i,j]:=sum[i-1,j]+sum[i,j-1]-sum[i-1,j-1]+a[i,j];
                        if a[i-1,j]=a[i,j] then ha[i,j]:=ha[i-1,j]+1 else ha[i,j]:=1;
                end;
                readln(gi);
        end;
end;

function check(i0,j0:longint):boolean;
var     i,j,i1,j1:longint;
begin
        if sum[i0,j0]-sum[i0-r,j0]-sum[i0,j0-c]+sum[i0-r,j0-c]<>ss then exit(false);
        for j1:=j0 downto j0-c+1 do
        begin
                i1:=i0;i:=r;j:=c+j1-j0;
                repeat
                        if (a[i1,j1]<>b[i,j]) then exit(false);
                        if (ha[i1,j1]>hb[i,j]) then
                                if i-hb[i,j]<=0 then break else exit(false);
                        if (ha[i1,j1]<hb[i,j]) then exit(false);
                        i1:=i1-hb[i,j];
                        i:=i-hb[i,j];
                until i=0;
        end;
        exit(true);
end;

procedure process;
var     i,j:longint;
begin
        ans:=0;
        for i:=r to m do
                for j:=c to n do
                        if check(i,j) then inc(ans);
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.













