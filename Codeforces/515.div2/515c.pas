Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';
        maxn=200010;

Var     q,vl,vr:longint;
        pos:array[0..maxn] of longint;
        f:array[0..maxn*2] of longint;

Procedure Update(i,x:longint);
Begin
        if i>2*maxn then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
End;

Function Quece(i:longint):longint;
Begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
End;

Procedure Process;
Var     i,id,q1,q2:longint;
        s:string[1];
Begin
        readln(q);
        vl:=maxn; vr:=maxn+1;
        for i:=1 to q do
        begin
                read(s); readln(id);
                if s='L' then
                begin
                        pos[id]:=vl;
                        update(vl,1);
                        dec(vl);
                end else
                if s='R' then
                begin
                        pos[id]:=vr;
                        update(vr,1);
                        inc(vr);
                end else
                begin
                        q1:=quece(pos[id]-1);
                        q2:=quece(maxn*2)-quece(pos[id]);
                        writeln(min(q1,q2));
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
