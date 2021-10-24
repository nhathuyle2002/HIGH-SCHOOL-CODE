Uses    Math;

Const   ginp='city.inp';
        gout='city.out';
        n = 19;
        dd:array[1..19,1..6] of longint = ((2,3,4,5,6,7),(1,3,7,8,9,10),(1,2,4,10,11,12),(1,3,5,12,13,14),(1,4,6,14,15,16),(1,5,7,16,17,18),
        (1,2,6,8,18,19),(2,7,9,19,0,0),(2,8,10,0,0,0),(2,3,9,11,0,0),(3,10,12,0,0,0),(3,4,11,13,0,0),(4,12,14,0,0,0),(4,5,13,15,0,0),
        (5,14,16,0,0,0),(5,6,15,17,0,0),(6,16,18,0,0,0),(6,7,17,19,0,0),(7,8,18,0,0,0));

Var     st,s,t,l,r,top:longint;
        f,trace1,trace2,o1,o2,q:array[0..1 shl n] of longint;

Function Getb(i,x:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Function Setb(i,x,t:longint):longint;
Begin
        if t=1 then setb:=x or (1 shl (i-1)) else
        setb:=x and (not (1 shl (i-1)));
End;

Procedure Enter;
Var     i,nn,p:longint;
Begin
        readln(nn);
        s:=0; t:=0;
        for i:=1 to nn do
        begin
                read(p);
                s:=setb(p,s,1);
        end;
        readln;
        for i:=1 to nn do
        begin
                read(p);
                t:=setb(p,t,1);
        end;
        readln;
End;

Procedure Process;
Var     x,y,i,ii:longint;
Begin
        for x:=1 to 1 shl n -1 do
        begin
                f[x]:=0;
                trace1[x]:=0; trace2[x]:=0;
        end;
        f[s]:=1;
        l:=1; r:=1; q[1]:=s;
        repeat
                x:=q[l]; inc(l);
                for i:=1 to n do
                        if getb(i,x)=1 then
                        for ii:=1 to 6 do
                                if dd[i,ii]=0 then break else
                                if getb(dd[i,ii],x)=0 then
                                begin
                                        y:=setb(i,x,0);
                                        y:=setb(dd[i,ii],y,1);
                                        if f[y]=0 then
                                        begin
                                                f[y]:=f[x]+1;
                                                trace1[y]:=i;
                                                trace2[y]:=dd[i,ii];
                                                if y=t then exit;
                                                inc(r); q[r]:=y;
                                        end;
                                end;
        until l>r;
End;

Procedure OP;
Var     i:longint;
Begin
        writeln(f[t]-1);
        top:=0;
        while t<>s do
        begin
                inc(top);
                o1[top]:=trace1[t]; o2[top]:=trace2[t];
                t:=setb(o1[top],t,1);
                t:=setb(o2[top],t,0);
        end;
        for i:=top downto 1 do writeln(o1[i],' ',o2[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
                OP;
        end;
        Close(input); Close(output);
End.
