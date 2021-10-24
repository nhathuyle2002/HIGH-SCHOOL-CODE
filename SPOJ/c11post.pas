const   ginp='ss.inp';
        gout='ss.out';
        di:array[1..8] of longint=(-1,1,0,0,-1,-1,1,1);
        dj:array[1..8] of longint=(0,0,-1,1,-1,1,-1,1);

var     gi,go:text;
        m,n,gmax,gmin,hmax,hmin,sl,ans,xx,yy:longint;
        ok:boolean;
        dx,dy:array[0..10001] of longint;
        a:array[0..101] of string;
        h:array[0..101,0..101] of longint;
        d:array[0..101,0..101] of boolean;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do readln(gi,a[i]);
        for i:=1 to m do
                for j:=1 to n do
                begin
                        if a[i,j]='P' then
                        begin
                                xx:=i;yy:=j;
                        end;
                        if a[i,j]='K' then
                        begin
                                inc(sl);
                                dx[sl]:=i;dy[sl]:=j;
                        end;
                end;
        gmax:=0;gmin:=round(1e9);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(gi,h[i,j]);
                        gmax:=max(gmax,h[i,j]);
                        gmin:=min(gmin,h[i,j]);
                end;
                readln(gi);
        end;
end;

function cdt(i,j:longint):boolean;
begin
        if (i<1) or (j<1) or (i>m) or (j>n) then exit(false);
        if d[i,j]=false then exit(false);
        if (h[i,j]<hmin) or (h[i,j]>hmax) then exit(false);
        exit(true);
end;

procedure dfs(i0,j0:longint);
var     i,j,k:longint;
begin
        d[i0,j0]:=false;
        for k:=1 to 8 do
        begin
                i:=i0+di[k];
                j:=j0+dj[k];
                if cdt(i,j) then dfs(i,j);
        end;
end;

procedure check;
var     i:longint;
begin
        ok:=false;
        for i:=1 to sl do
                if d[dx[i],dy[i]] then exit;
        ok:=true;
end;

procedure process;
var     l,r,mid,i,j:longint;
begin
        l:=0;r:=gmax-gmin;
        while l<>r do
        begin
                mid:=(l+r) div 2;
                for i:=1 to m do
                begin
                        for j:=1 to n do
                        begin
                                hmin:=h[i,j];
                                hmax:=h[i,j]+mid;
                                if (h[xx,yy]>=hmin) and (h[xx,yy]<=hmax) then
                                begin
                                        fillchar(d,sizeof(d),true);
                                        dfs(xx,yy);check;
                                        if ok then break;
                                end;
                        end;
                        if ok then break;
                end;
                if ok then r:=mid else l:=mid+1;
        end;
        ans:=l;
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
