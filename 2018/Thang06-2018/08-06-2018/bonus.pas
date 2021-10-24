const   ginp='bonus.inp';
        gout='bonus.out';

var     gi,go:text;
        n,r,k:longint;
        res:int64;
        a,d:array[0..502,0..502] of longint;

procedure xldb;
var     i,j,x0,y0:longint;
begin
        for i:=1 to n do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
        for i:=1 to k do
        begin
                readln(gi,x0,y0);
                if x0<>0 then
                if d[x0,y0]<>1 then
                begin
                        d[x0,y0]:=1;
                        res:=res+a[x0,y0];
                end;
        end;
        write(go,res);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure create;
var     i,j,x0,y0:longint;
begin
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,a[i,j]);
                        a[i,j]:=a[i-1,j]+a[i,j];
                end;
                readln(gi);
        end;
        for i:=1 to k do
        begin
                readln(gi,x0,y0);
                if x0<>0 then
                for j:=y0 to min(y0+r-1,n) do
                begin
                        d[x0,j]:=d[x0,j]+1;
                        d[min(x0+r-1,n),j]:=d[min(x0+r-1,n),j]-1;
                end;
        end;
end;

procedure process;
var     i,j,cou,v:longint;
begin
        for j:=1 to n do
        begin
                cou:=0;i:=0;
                repeat
                        inc(i);
                        while (d[i,j]=0) and (i<=n) do inc(i);
                        if i>n then break;
                        cou:=d[i,j];v:=i;
                        while (cou<>0) do
                        begin
                                inc(i);
                                cou:=cou+d[i,j];
                        end;
                        res:=res+a[i,j]-a[v-1,j];
                until i>n;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,r,k);
        if r<>1 then
        begin
                create;
                process;
        end
        else xldb;
        close(gi);close(go);
end.

