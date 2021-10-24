const   ginp='ss.inp';
        gout='ss.out';
        maxn=1501;
        di:array[1..4] of longint= (-1,1,0,0);
        dj:array[1..4] of longint= (0,0,-1,1);

var     gi,go:text;
        m,n,ans,l,r:longint;
        ok:boolean;
        x,y:array[1..2] of longint;
        a:array[0..maxn] of ansistring;
        d:array[0..maxn,0..maxn] of longint;
        qi,qj:array[0..maxn*maxn] of longint;

procedure input;
var     i,gt,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do readln(gi,a[i]);
        gt:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]='L' then
                        begin
                                inc(gt);
                                x[gt]:=i;y[gt]:=j;
                        end;
end;

function cdt(i,j,gt:longint):longint;
begin
        if (i<1) or (j<1) or (i>m) or (j>n) then exit(0);
        if d[i,j]=gt then exit(0);
        exit(1);
end;

procedure push(i,j,gt:longint);
begin
        inc(r);
        qi[r]:=i;qj[r]:=j;
        d[i,j]:=gt;
end;

procedure dfs0(i,j,gt:longint);
var     k,i0,j0:longint;
begin
        d[i,j]:=gt;
        for k:=1 to 4 do
        begin
                i0:=i+di[k];
                j0:=j+dj[k];
                if (cdt(i0,j0,gt)=1) and (a[i0,j0]<>'X') then
                begin
                        push(i0,j0,gt);
                        dfs0(i0,j0,gt);
                end;
        end;
end;

procedure dfs(i,j,gt,tt:longint);
var     i0,j0,k,tm:longint;
begin
        if ok then exit;
        for k:=1 to 4 do
        begin
                i0:=i+di[k];
                j0:=j+dj[k];
                if cdt(i0,j0,gt)=1 then
                begin
                        if (d[i0,j0]=0) and (a[i0,j0]='X') and (tt=1) then
                        begin
                                push(i0,j0,gt);
                                dfs(i0,j0,gt,tt+1);
                        end else
                        if (d[i0,j0]=0) and (a[i0,j0]<>'X') then
                        begin
                                push(i0,j0,gt);
                                dfs(i0,j0,gt,tt);
                        end else
                        if (d[i0,j0]<>0) then
                        begin
                                ok:=true;
                                exit;
                        end;
                end;
        end;
end;

procedure process;
var     i,j,r0:longint;
begin
        fillchar(d,sizeof(d),0);
        l:=0;r:=0;
        ans:=0;
        push(x[1],y[1],1);
        dfs0(x[1],y[1],1);
        if d[x[2],y[2]]=1 then exit;
        push(x[2],y[2],2);
        dfs0(x[2],y[2],2);
        ok:=false;
        repeat
                inc(ans);
                r0:=r;
                while l<=r0 do
                begin
                        dfs(qi[l],qj[l],d[qi[l],qj[l]],1);
                        inc(l);
                end;
                if ok then exit;
        until l>=r;
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
