Uses    Math;

Const   ginp='deliver.inp';
        gout='deliver.out';
        maxn=100010;
        oo=trunc(1e16);

Var     st,n,s,t,delta:longint;
        x,a,k:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,delta,s,t);
        for i:=1 to n do readln(x[i],a[i],k[i]);
End;

Procedure Process1;
Var     u,v:longint;
        d:array[0..maxn] of int64;
        put:array[0..maxn] of longint;
Begin
        for u:=0 to n do
        begin
                d[u]:=oo;
                put[u]:=0;
        end;
        d[s]:=0;
        repeat
                u:=0;
                for v:=1 to n do
                        if (put[v]=0) and (d[v]<d[u]) then u:=v;
                put[u]:=1;
                if (u=0) or (u=t) then break;
                for v:=1 to n do
                        if abs(x[u]-x[v])<=k[u] then d[v]:=min(d[v],d[u]+int64(a[u])*abs(x[u]-x[v])+delta);
        until false;
        if put[t]=0 then writeln(-1) else writeln(d[t]-delta);
End;

Procedure Process2;
Var     l,r,minx,maxx,ls,rs:longint;
        res:int64;
Begin
        res:=int64(a[1])*abs(x[s]-x[t]);
        l:=s; r:=s;
        minx:=x[s]-t; maxx:=x[s]+t;
        repeat
                ls:=l; rs:=r;
                while (ls>1) and (x[ls]>=minx) do dec(ls);
                while (rs<n) and (x[rs]<=maxx) do inc(rs);
                if (ls<=t) and (t<=rs) then break;
        until false;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process1;
        end;
        Close(input); Close(output);
End.
