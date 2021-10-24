Uses    Math;

Const   ginp='purple.inp';
        gout='purple.out';
        maxn=2*trunc(1e5)+100;

Var     n,q,res:longint;
        a,b:array[0..maxn] of ansistring;
        pos:array[0..maxn] of longint;
        f:array[0..maxn,0..18] of longint;
        k,k2,l0,r0:longint;
        c,d,g:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,tmp:longint;
        t:ansistring;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[pos[random(r-l+1)+l]];
        repeat
                while a[pos[i]]<t do inc(i);
                while a[pos[j]]>t do dec(j);
                if i<=j then
                begin
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Sort2(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while c[i]<t do inc(i);
                while c[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort2(l,j); sort2(i,r);
End;

Function Get(l,r:longint):longint;
Var     x:longint;
Begin
        x:=trunc(log2(r-l+1));
        get:=min(f[l,x],f[r-1 shl x+1,x]);
End;

Procedure Push(i:longint);
Begin
        while (l0<=r0) and (c[i]<=c[d[r0]]) do dec(r0);
        inc(r0); d[r0]:=i;
End;

Procedure Pop(i:longint);
Begin
        while (l0<=r0) and (d[l0]<=i) do inc(l0);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,q);
        for i:=1 to n do
        begin
                readln(a[i]);
                pos[i]:=i;
        end;
        sort(1,n);
End;

Procedure Init;
Var     i,j,n0:longint;
Begin
        for i:=1 to n do b[pos[i]]:=a[i];
        for i:=1 to n-1 do
        begin
                n0:=min(length(b[i]),length(b[i+1]));
                for j:=1 to n0+1 do
                        if (j>n0) or (b[i,j]<b[i+1,j]) then break;
                f[i,0]:=j-1;
        end;
        for j:=1 to trunc(log2(n-1)) do
                for i:=1 to n-1 shl j+1 do
                        f[i,j]:=min(f[i,j-1],f[i+1 shl (j-1),j-1]);
End;

Procedure Process;
Var     i:longint;
Begin
        g[0]:=0;
        for q:=1 to q do
        begin
                readln(k,k2);
                for i:=1 to k do
                begin
                        read(c[i]);
                        c[i]:=pos[c[i]];
                end;
                readln;

                sort2(1,k);

                dec(k2); res:=0;
                if k2=0 then
                begin
                        for i:=k downto 2 do
                                g[i]:=get(c[i-1],c[i]-1);
                        g[1]:=0; g[k+1]:=0;
                        for i:=1 to k do res:=res+length(b[c[i]])-max(g[i],g[i+1]);
                        writeln(res);
                        continue;
                end;

                l0:=1; r0:=0;
                for i:=k downto 2 do
                        c[i]:=get(c[i-1],c[i]-1);
                c[1]:=0;
                for i:=2 to k2 do push(i);
                        for i:=k2+1 to k do
                        begin
                                push(i); pop(i-k2);
                                g[i]:=c[d[l0]];
                        end;
                        g[k2]:=0; g[k+1]:=0;
                        for i:=k2+1 to k do
                                if g[i]>max(g[i-1],g[i+1]) then res:=res+g[i]-max(g[i-1],g[i+1]);
                writeln(res);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
