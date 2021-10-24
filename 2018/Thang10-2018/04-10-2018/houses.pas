Uses    Math;

Const   ginp='houses.inp';
        gout='houses.out';
        maxn=1051;
        base=trunc(1e9)+13;
        di:array[1..4] of longint= (-1,1,0,0);
        dj:array[1..4] of longint= (0,0,-1,1);

Var     m,n,sl,res:longint;
        a,id:array[0..maxn,0..maxn] of longint;
        pow:array[0..maxn] of int64;
        hash:array[0..maxn*maxn,1..4] of int64;
        mv:array[0..maxn*maxn,1..4] of longint;

Procedure Dfs(i,j:longint);
var     k:longint;
Begin
        a[i,j]:=0; id[i,j]:=sl;
        mv[sl,1]:=min(mv[sl,1],i); mv[sl,2]:=max(mv[sl,2],i);
        mv[sl,3]:=min(mv[sl,3],j); mv[sl,4]:=max(mv[sl,4],j);
        for k:=1 to 4 do
                if a[i+di[k],j+dj[k]]=1 then dfs(i+di[k],j+dj[k]);
End;

Procedure Cong(var x:int64; y:int64);
Begin
        x:=(x+y) mod base;
End;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:int64;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=hash[random(r-l+1)+l,1];
        repeat
                while hash[i,1]<t do inc(i);
                while hash[j,1]>t do dec(j);
                if i<=j then
                begin
                        tmp:=hash[i,1]; hash[i,1]:=hash[j,1]; hash[j,1]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
        sl:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]=1 then
                        begin
                                inc(sl);
                                mv[sl,1]:=m; mv[sl,2]:=1; mv[sl,3]:=n; mv[sl,4]:=1;
                                dfs(i,j);
                        end;
        pow[0]:=1;
        for i:=1 to max(m,n) do
                pow[i]:=(pow[i-1]*maxn) mod base;
End;

Procedure Process;
Var     i,j,v:longint;
Begin
        for i:=1 to m do
        for j:=1 to n do
        begin
                if id[i,j]=0 then continue;
                v:=id[i,j];
                Cong(hash[v,1], pow[i-mv[v,1]]*pow[j-mv[v,3]]);
                Cong(hash[v,2], pow[i-mv[v,1]]*pow[mv[v,4]-j]);
                Cong(hash[v,3], pow[mv[v,2]-i]*pow[mv[v,4]-j]);
                Cong(hash[v,4], pow[mv[v,2]-i]*pow[j-mv[v,3]]);
        end;
        for i:=1 to sl do
                for j:=2 to 4 do
                        hash[i,1]:=min(hash[i,1],hash[i,j]);
        sort(1,sl);
        res:=0; hash[0,1]:=-1;
        for i:=1 to sl do
                if hash[i,1]<>hash[i-1,1] then inc(res);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
