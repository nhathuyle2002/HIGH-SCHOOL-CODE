const   ginp='ss.inp';
        gout='ss.out';
        maxg=367980;

type    save=record g,k:longint;end;

var     gi,go:text;
        n,x,st,fst,res:longint;
        a:array[0..34] of longint;
        b:array[0..16500] of save;
        f:array[0..maxg] of longint;

procedure dfs1(i,sum,sl:longint);
begin
        if i=35 then
        begin
                inc(n);
                b[n].g:=sum;b[n].k:=sl;
                exit;
        end;
        dfs1(i+1,sum,sl);
        dfs1(i+1,sum+a[i],sl+1);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure dfs2(i,sum,sl:longint);
begin
        if i=21 then
        begin
                f[sum]:=max(f[sum],sl);
                exit;
        end;
        dfs2(i+1,sum,sl);
        dfs2(i+1,sum+a[i],sl+1);
end;

procedure create;
var     i:longint;
begin
        a[1]:=2;a[2]:=3;a[3]:=5;
        for i:=4 to 34 do a[i]:=a[i-1]+a[i-2]+a[i-3];
        dfs1(21,0,0);
        for i:=1 to maxg do f[i]:=-1;
        dfs2(1,0,0);
end;

procedure process;
var     i:longint;
begin
        if x<=maxg then res:=f[x] else
        begin
                res:=-1;
                for i:=1 to n do
                        if (x>=b[i].g) and (x-b[i].g<=maxg) then
                        if f[x-b[i].g]<>-1 then res:=max(res,f[x-b[i].g]+b[i].k);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        create;
        readln(gi,st);
        for fst:=1 to st do
        begin
                readln(gi,x);
                process;
                writeln(go,'Case #',fst,': ',res);
        end;
        close(gi);close(go);
end.
