const   ginp='psubtree.inp';
        gout='psubtree.out';
        maxv=10;
        base=trunc(1e9);

type    edge=record y,k:longint;dd:boolean;end;
        bignum=array[0..maxv] of int64;

var     n:longint;
        e:array[-501..501] of edge;
        head:array[0..501] of longint;
        f:array[0..501,0..501] of bignum;
        res:bignum;

procedure add(i,u,v:longint);
begin
        with e[i] do
        begin
                y:=v;
                k:=head[u];
                dd:=true;
        end;
        head[u]:=i;
end;

procedure enter;
var     i,u,v:longint;
begin
        readln(n);
        for i:=1 to n-1 do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
end;

procedure max(var x:bignum;y:bignum);
var     i:longint;
begin
        if x[0]>y[0] then exit else
        if x[0]<y[0] then
        begin
                x:=y;exit;
        end else
        for i:=x[0] downto 1 do
                if x[i]>y[i] then exit else
                if x[i]<y[i] then
                begin
                        x:=y;exit;
                end;
end;

operator * (x,y:bignum) z:bignum;
var     i,j,nho,tm:longint;
begin
        fillchar(z,sizeof(z),0);
        for i:=1 to x[0] do
                for j:=1 to y[0] do
                        z[i+j-1]:=z[i+j-1]+x[i]*y[j];
        z[0]:=x[0]+y[0]-1;
        nho:=0;
        for i:=1 to z[0] do
        begin
                z[i]:=z[i]+nho;
                nho:=z[i] div base;
                z[i]:=z[i] mod base;
        end;
        if nho>0 then
        begin
                inc(z[0]);
                z[z[0]]:=nho;
        end;
end;

operator * (x:bignum;y:longint) z:bignum;
var     i,nho:longint;
        sum:int64;
begin
        nho:=0;
        for i:=1 to x[0] do
        begin
                sum:=x[i]*y+nho;
                nho:=sum div base;
                z[i]:=sum mod base;
        end;
        if nho=0 then z[0]:=x[0] else
        begin
                z[0]:=x[0]+1;
                z[z[0]]:=nho;
        end;
end;

procedure dfs(u:longint);
var     i,v,j,jj:longint;
        g:array[0..501] of bignum;
begin
        f[u,1,0]:=1;f[u,1,1]:=1;
        i:=head[u];
        while i<>0 do
        begin
                if e[i].dd then
                begin
                        e[-i].dd:=false;
                        v:=e[i].y;
                        dfs(v);
                        g:=f[u];
                        for j:=1 to n do
                                for jj:=1 to n do
                                begin
                                        if (g[j,0]>0) and (f[v,jj,0]>0) then max(f[u,j],g[j]*f[v,jj]*jj);
                                        if (j-jj>0) and (g[j-jj,0]>0) and (f[v,jj,0]>0) then max(f[u,j],g[j-jj]*f[v,jj]);
                                end;
                end;
                i:=e[i].k;
        end;
end;

procedure process;
var     i:longint;
        t:string[10];
begin
        dfs(1);
        res[0]:=1;res[1]:=1;
        for i:=1 to n do
                max(res,f[1,i]*i);
        write(res[res[0]]);
        for i:=res[0]-1 downto 1 do
        begin
                str(res[i],t);
                while length(t)<9 do t:='0'+t;
                write(t);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
