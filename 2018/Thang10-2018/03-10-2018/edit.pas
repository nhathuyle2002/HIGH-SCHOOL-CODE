Const   ginp='edit.inp';
        gout='edit.out';
        di:array[1..3] of longint =(0,1,1);
        dj:array[1..3] of longint =(1,0,1);
        maxn=1010;

Var     m,n,t1,t2,t3,cou:longint;
        a,b:ansistring;
        ou:array[0..2*maxn] of longint;
        f,trace:array[0..maxn,0..maxn] of longint;

Function Min(x,y,z:longint):longint;
Begin
        min:=x;
        if y<min then min:=y;
        if z<min then min:=z;
End;

Procedure Enter;
Begin
        readln(a); m:=length(a);
        readln(b); n:=length(b);
        read(t1,t2,t3);
End;

Procedure Answer(i,j:longint);
Begin
        if trace[i,j]=0 then exit;
        inc(cou); ou[cou]:=trace[i,j];
        answer(i-di[ou[cou]],j-dj[ou[cou]]);
End;

Procedure OOutput(i,j,v,lth:longint);
Begin
        if v=0 then exit;
        i:=i+di[ou[v]]; j:=j+dj[ou[v]];
        if ou[v]=1 then
        begin
                inc(lth);
                writeln('INS ',i+lth,' ',b[j]);
        end else
        if ou[v]=2 then
        begin
                writeln('DEL ',i+lth);
                dec(lth);
        end else
        if a[i]<>b[j] then writeln('REP ',i+lth,' ',b[j]);
        OOutput(i,j,v-1,lth);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to m do
        begin
                f[i,0]:=t2*i;
                trace[i,0]:=2;
        end;
        for j:=1 to n do
        begin
                f[0,j]:=t1*j;
                trace[0,j]:=1;
        end;
        for i:=1 to m do
                for j:=1 to n do
                if a[i]=b[j] then
                begin
                        f[i,j]:=f[i-1,j-1];
                        trace[i,j]:=3;
                end else
                begin
                        f[i,j]:=min(f[i,j-1]+t1,f[i-1,j]+t2,f[i-1,j-1]+t3);
                        if f[i,j]=f[i,j-1]+t1 then trace[i,j]:=1 else
                        if f[i,j]=f[i-1,j]+t2 then trace[i,j]:=2 else
                        trace[i,j]:=3;
                end;
        writeln(f[m,n]);
        cou:=0; answer(m,n);
        OOutput(0,0,cou,0);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
