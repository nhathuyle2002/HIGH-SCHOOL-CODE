const   ginp='castle.inp';
        gout='castle.out';
        hs:array[0..15] of double =(1,0.9,0.9,0.81,0.9,0.8,0.81,0.72,0.9,0.81,0.8,0.72,0.81,0.72,0.72,0.64);
        dd:array[1..4,1..2] of longint =((0,-1),(-1,0),(0,1),(1,0));
        rv:array[1..4] of longint =(3,4,1,2);

var     m,n,cou:longint;
        maxs:double;
        a,id:array[0..101,0..101] of longint;
        sum:array[0..10010] of double;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

function getb(x,i:longint):longint;
begin
        getb:=(x shr (i-1)) and 1;
end;

function setb(i,x,tt:longint):longint;
begin
        if tt=0 then setb:=x and (not (1 shl (i-1)))
        else setb:=x or (1 shl (i-1));
end;

procedure dfs(i,j:longint);
var     k,i0,j0:longint;
begin
        id[i,j]:=cou;
        sum[cou]:=sum[cou]+hs[a[i,j]];
        for k:=1 to 4 do
        begin
                i0:=i+dd[k,1];j0:=j+dd[k,2];
                if (id[i0,j0]=0) and (getb(a[i,j],k)=0) then dfs(i0,j0);
        end;
end;

function max(x,y:double):double;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,k,x1,x2,i0,j0:longint;
        tmp:double;
begin
        for i:=1 to m do
                for j:=1 to n do
                        if id[i,j]=0 then
                        begin
                                inc(cou);
                                dfs(i,j);
                        end;
        writeln(cou);
        maxs:=0;
        for k:=1 to cou do maxs:=max(maxs,sum[k]);
        writeln(maxs:0:2);
        maxs:=0;
        for i:=1 to m do
        for j:=1 to n do
        begin
                for k:=1 to 4 do
                if getb(a[i,j],k)=1 then
                begin
                        i0:=i+dd[k,1];j0:=j+dd[k,2];
                        if (i0=0) or (j0=0) or (i0>m) or (j0>n) or (id[i,j]=id[i0,j0]) then continue;
                        tmp:=-hs[a[i,j]]-hs[a[i0,j0]];
                        x1:=setb(k,a[i,j],0);
                        x2:=setb(rv[k],a[i0,j0],0);
                        tmp:=tmp+hs[x1]+hs[x2];
                        maxs:=max(maxs,tmp+sum[id[i,j]]+sum[id[i0,j0]]);
                end;
        end;
        writeln(maxs:0:2);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
