const   ginp='firework.inp';
        gout='firework.out';
        oo=trunc(1e9);
        md=410;

type    //save=record g,w:longint;end;
        edge=record y,w,k:longint;dd:boolean;end;

var     n,m:longint;
        e:array[-310..310] of edge;
        head:array[0..310] of longint;
        f:array[0..310,0..md] of longint;
        a:array[0..300010] of longint;

function abs(x:longint):longint;
begin
        if x>0 then exit(x) else exit(-x);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure main1;
var     i,tm:longint;
        sum:int64;
begin
        sum:=0;
        for i:=1 to m do readln(tm,a[i]);
        sort(1,m);
        for i:=1 to m do sum:=sum+abs(a[m div 2+1]-a[i]);
        write(sum);
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

procedure dfs(u:longint);
var     i,v,j,jj,tmp:longint;
begin
        i:=head[u];
        while i<>0 do
        begin
                if e[i].dd then
                begin
                        e[-i].dd:=false;
                        v:=e[i].y;
                        if v>n then
                                for j:=0 to md do f[u,j]:=f[u,j]+abs(j-e[i].w)
                        else begin
                                dfs(v);
                                for j:=0 to md do
                                begin
                                        tmp:=oo;
                                        for jj:=0 to j do tmp:=min(tmp,f[v,jj]+abs(j-jj-e[i].w));
                                        f[u,j]:=f[u,j]+tmp;
                                end;
                        end;
                end;
                i:=e[i].k;
        end;
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
        dfs(1);
        res:=f[1,0];
        for j:=0 to md do res:=min(res,f[1,j]);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(n,m);
        if n=1 then main1 else main2;
        close(input);close(output);
end.
