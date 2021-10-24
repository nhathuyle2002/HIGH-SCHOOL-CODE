Uses    Math;

Const   ginp='mqueen.inp';
        gout='mqueen.out';
        maxn=10;
        oo=10000;

Var     n,top,res:longint;
        vx,vy,a:array[0..maxn] of longint;
        o:array[0..1001,0..maxn] of longint;
        dh,dc1,dc2:array[-maxn..2*maxn] of boolean;
        f:array[0..1 shl maxn-1] of longint;

Procedure Enter;
Var     i:longint;
        s:string[3];
        s2:string[1];
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(s);
                vx[i]:=ord(s[1])-ord('a')+1;
                if s[3]=' ' then vy[i]:=ord(s[2])-ord('1')+1 else
                begin
                        vy[i]:=10;
                        read(s2);
                end;
        end;
End;

Procedure Try(i:longint);
Var     j,k:longint;
Begin
        if i=n+1 then
        begin
                inc(top); o[top]:=a;
                exit;
        end;
        for j:=1 to n do
                if (dh[j]) and (dc1[i-j]) and (dc2[i+j]) then
                begin
                        dh[j]:=false; dc1[i-j]:=false; dc2[i+j]:=false;
                        a[i]:=j;
                        try(i+1);
                        dh[j]:=true; dc1[i-j]:=true; dc2[i+j]:=true;
                end;
End;

Procedure Init;
Begin
        fillchar(dh,sizeof(dh),true);
        fillchar(dc1,sizeof(dc1),true);
        fillchar(dc2,sizeof(dc2),true);
        top:=0;
        try(1);
End;

Function Getb(i,x:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Function Setb(i,x,t:longint):longint;
Begin
        if t=1 then setb:=x or (1 shl (i-1))
        else setb:=x and (not (1 shl (i-1)));
End;

Procedure Process(u:longint);
Var     x,i,cou:longint;
Begin
        f[0]:=0;
        for x:=1 to 1 shl n-1 do
        begin
                f[x]:=oo; cou:=0;
                for i:=1 to n do
                        if getb(i,x)=1 then inc(cou);
                for i:=1 to n do
                        if getb(i,x)=1 then
                                f[x]:=min(f[x],f[setb(i,x,0)]+max(abs(vx[i]-cou),abs(vy[i]-o[u,cou])));
        end;
        res:=min(res,f[1 shl n-1]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        res:=oo;
        for top:=1 to top do Process(top);
        if res=oo then write(-1) else write(res);
        Close(input); Close(output);
End.
