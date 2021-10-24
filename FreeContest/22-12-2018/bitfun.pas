Uses    Math;

Const   ginp='bitfun.inp';
        gout='bitfun.out';
        maxn=100001;
        maxb=18;
        mm=31;

Var     st:longint;
        f:array[0..maxn] of boolean;
        d2:array[0..mm,0..mm] of boolean;
        d3:array[0..mm,0..mm,0..mm] of boolean;
        d4:array[0..mm,0..mm,0..mm,0..mm] of boolean;
        sl1:longint;
        n:int64;

FUnction Getb(i:longint; x:int64):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Function Daob(i,x:longint):longint;
Begin
        daob:=x xor (1 shl (i-1));
End;

Procedure Init1;
Var     x,i,j,y:longint;
Begin
        fillchar(f,sizeof(f),false);
        for x:=1 to maxn do
        if not f[x] then
                for i:=1 to maxb do
                if getb(i,x)=1 then
                        for j:=i+1 to maxb do
                        if getb(j,x)=0 then
                        begin
                                y:=daob(j,daob(i,x));
                                if y<=maxn then f[y]:=true;
                        end;
End;

Procedure Init2;
Var     i,j,k:longint;
Begin
        fillchar(d2,sizeof(d2),false);
        for j:=2 to mm do
        for i:=1 to j-1 do
        if not d2[i,j] then
                for k:=i+1 to mm do
                if k=j then continue else
                if k<j then d2[k,j]:=true else
                begin
                        d2[j,k]:=true;
                        d2[i,k]:=true;
                end;
End;

Procedure Init3;
Var     i,j,k,t:longint;
Begin
        fillchar(d3,sizeof(d3),false);
        for k:=3 to mm do
        for j:=2 to k-1 do
        for i:=1 to j-1 do
        if not d3[i,j,k] then
                for t:=i+1 to mm do
                if (t=j) or (t=k) then continue else
                if t<j then d3[t,j,k]:=true else
                if t<k then
                begin
                        d3[i,t,k]:=true;
                        d3[j,t,k]:=true;
                end else
                begin
                        d3[i,j,t]:=true;
                        d3[i,k,t]:=true;
                        d3[j,k,t]:=true;
                end;
End;

Procedure Init4;
Var     i,j,k,t,p:longint;
Begin
        fillchar(d4,sizeof(d4),false);
        for t:=4 to mm do
        for k:=3 to t-1 do
        for j:=2 to k-1 do
        for i:=1 to j-1 do
        if not d4[i,j,k,t] then
                for p:=i+1 to mm do
                if (p=j) or (p=k) or (p=t) then continue else
                if p<j then d4[p,j,k,t]:=true else
                if p<k then
                begin
                        d4[i,p,k,t]:=true;
                        d4[j,p,k,t]:=true;
                end else
                if p<t then
                begin
                        d4[i,j,p,t]:=true;
                        d4[i,k,p,t]:=true;
                        d4[j,k,p,t]:=true;
                end else
                begin
                        d4[i,j,k,p]:=true;
                        d4[i,j,t,p]:=true;
                        d4[i,k,t,p]:=true;
                        d4[j,k,t,p]:=true;
                end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        sl1:=0;
        if n=0 then exit;
        for i:=1 to trunc(log2(n))+1 do
                if getb(i,n)=1 then inc(sl1);
End;

Procedure Process;
Var     i:longint;
        p:array[1..4] of longint;
        ok:boolean;
Begin
        sl1:=0;
        for i:=1 to trunc(log2(n))+1 do
                if getb(i,n)=1 then
                begin
                        inc(sl1);
                        p[sl1]:=i;
                end;
        if sl1=2 then ok:=d2[p[1],p[2]] else
        if sl1=3 then ok:=d3[p[1],p[2],p[3]] else
        if sl1=4 then ok:=d4[p[1],p[2],p[3],p[4]];
        if ok then writeln('YES') else writeln('NO');

End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init1;
        Init2;
        Init3;
        Init4;
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                if n<=maxn then
                begin
                        if f[n] then writeln('YES') else writeln('NO');
                end else
                if (sl1=1) then writeln('YES') else
                if sl1=trunc(log2(n))+1 then writeln('NO') else
                Process;
        end;
        Close(input); Close(output);
End.
