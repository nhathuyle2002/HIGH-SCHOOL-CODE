const   ginp='firework.inp';
        gout='firework.out';
        oo=trunc(1e18);
        ooo=trunc(1e9);
        md=400;

type    save=record g,w:longint;end;
        edge=record y,w,k:longint;dd:boolean;end;

var     n,m:longint;
        e:array[-310..310] of edge;
        head:array[0..310] of longint;
        f:array[0..310,0..md] of save;
        a:array[0..300010] of int64;

function abs1(x:int64):int64;
begin
        if x>0 then exit(x) else exit(-x);
end;

function abs2(x:longint):longint;
begin
        if x>0 then exit(x) else exit(-x);
end;

function min1(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function min2(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure main1;
var     i,l,r,mid:longint;
        ma,sum1,sum2,res:int64;
begin
        ma:=0;
        for i:=1 to m do
        begin
                readln(l,a[i]);
                if a[i]>ma then ma:=a[i];
        end;
        l:=1;r:=ma;
        res:=oo;
        while l<r do
        begin
                mid:=(l+r)>>1;
                sum1:=0;sum2:=0;
                for i:=1 to m do sum1:=sum1+abs1(a[i]-l);
                for i:=1 to m do sum2:=sum2+abs1(r-a[i]);
                if sum1<sum2 then l:=mid+1 else r:=m;
                res:=min1(res,min1(sum1,sum2));
        end;
        write(res);
end;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                y:=v;w:=c;
                k:=head[u];
                dd:=true;
        end;
        head[u]:=i;
end;

procedure dfs(u,wc:longint);
var     i,v,j,jj:longint;
begin
        i:=head[u];
        while i<>0 do
        begin
                if e[i].dd then
                begin
                        e[-i].dd:=false;
                        v:=e[i].y;
                        if v>n then
                                for j:=1 to md do f[u,j].g:=f[u,j].g+abs2(j-e[i].w)
                        else begin
                                dfs(v,e[i].w);
                                for j:=1 to md do f[u,j].g:=f[u,j].g+f[v,j].w;
                        end;
                end;
                i:=e[i].k;
        end;
        for j:=1 to md do f[u,j].w:=ooo;
        for j:=1 to md do
                for jj:=j-1 downto 1 do f[u,j].w:=min2(f[u,j].w,f[u,jj].g+abs2(j-wc-jj));
end;

procedure main2;
var     i,v,c,j,res:longint;
begin
        for i:=2 to n+m do
        begin
                readln(v,c);
                add(i,i,v,c);
                add(-i,v,i,c);
        end;
        dfs(1,0);
        res:=f[1,1].g;
        for j:=2 to md do res:=min2(res,f[1,j].g);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(n,m);
        if n=1 then main1 else main2;
        close(input);close(output);
end.
