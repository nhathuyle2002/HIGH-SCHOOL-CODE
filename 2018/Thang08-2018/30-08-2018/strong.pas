const   ginp='strong.inp';
        gout='strong.out';
        di:array[1..4] of longint= (-1,1,0,0);
        dj:array[1..4] of longint= (0,0,-1,1);

var     n,k,cou,ssum,res:longint;
        a:array[0..501] of ansistring;
        sl,d:array[0..250000] of longint;
        id,sum:array[0..501,0..501] of longint;

procedure dfs(i,j:longint);
var     t,i0,j0:longint;
begin
        id[i,j]:=cou;
        inc(sl[cou]);
        for t:=1 to 4 do
        begin
                i0:=i+di[t];
                j0:=j+dj[t];
                if id[i0,j0]=0 then dfs(i0,j0);
        end;
end;

procedure enter;
var     i,j:longint;
begin
        readln(n,k);
        for i:=1 to n do
        begin
                readln(a[i]);
                for j:=1 to n do
                begin
                        sum[i,j]:=sum[i-1,j]+sum[i,j-1]-sum[i-1,j-1];
                        if a[i,j]='X' then
                        begin
                                inc(sum[i,j]);
                                id[i,j]:=-1;
                        end;
                end;
        end;
        for i:=1 to n do
        begin
                id[i,0]:=-1;id[i,n+1]:=-1;
                id[0,i]:=-1;id[n+1,i]:=-1;
        end;
        for i:=1 to n do
                for j:=1 to n do
                        if id[i,j]=0 then
                        begin
                                inc(cou);
                                dfs(i,j);
                        end;
end;

procedure push(i,j:longint);
begin
        if id[i,j]=-1 then exit;
        inc(d[id[i,j]]);
        if d[id[i,j]]=1 then ssum:=ssum+sl[id[i,j]];
end;

procedure pop(i,j:longint);
begin
        if id[i,j]=-1 then exit;
        dec(d[id[i,j]]);
        if d[id[i,j]]=0 then ssum:=ssum-sl[id[i,j]];
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,ii:longint;
begin
        res:=0;
        for i:=k to n do
        begin
                ssum:=0;
                for j:=1 to cou do d[j]:=0;
                for j:=0 to k-1 do
                        for ii:=i-k to i+1 do push(ii,j+1);
                for j:=k to n do
                begin
                        for ii:=i-k to i+1 do
                        begin
                                push(ii,j+1);
                                pop(ii,j-k);
                        end;
                        res:=max(res,ssum+sum[i,j]-sum[i,j-k]-sum[i-k,j]+sum[i-k,j-k]);
                end;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
