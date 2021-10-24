Const   ginp='paper.inp';
        gout='paper.out';
        maxn=1 shl 11+1;
        di:array[1..4] of longint= (-1,1,0,0);
        dj:array[1..4] of longint= (0,0,-1,1);

Var     n,k,d11:longint;
        ctp,ccol,crow:int64;
        d:array[0..maxn,0..maxn] of longint;
        qi,qj:array[0..maxn*maxn] of longint;

Procedure Bfs;

Var     i,j,ij,i0,j0,l,r:longint;
Begin
        ctp:=0;
        if n>k then inc(k);
        for i:=1 to 1 shl k do
        for j:=1 to 1 shl k do
        if d[i,j]=0 then
        begin
                inc(ctp); d[i,j]:=ctp;
                l:=1; r:=1; qi[1]:=i; qj[1]:=j;
                repeat
                        for ij:=1 to 4 do
                        begin
                                i0:=qi[l]+di[ij]; j0:=qj[l]+dj[ij];
                                if not ((i0<1) or (j0<1) or (i0>1 shl k) or (j0>1 shl k) or (d[i0,j0]<>0)) then
                                begin
                                        inc(r);
                                        qi[r]:=i0; qj[r]:=j0;
                                        d[i0,j0]:=ctp;
                                end;
                        end;
                        inc(l);
                until l>r;
        end;
End;

Procedure Enter;
Var     i,j,q,m:longint;
Begin
        readln(n,k,m);
        for q:=1 to m do
        begin
                readln(i,j);
                j:=1 shl k-j+1;
                d[i,j]:=-1;
                d[1 shl (k+1)-i+1,j]:=-1;
                d[i,1 shl (k+1)-j+1]:=-1;
                d[1 shl (k+1)-i+1,1 shl (k+1)-j+1]:=-1;
        end;
End;

Procedure Init;
Var     i,j:longint;
        dd:array[0..maxn*maxn] of boolean;
Begin
        for j:=1 to ctp do dd[j]:=true;
        d11:=0;
        for i:=1 to 1 shl k do
                for j:=1 to 1 shl k do
                if (d[1,i]<>-1) and (dd[d[1,i]]) and (d[1,i]=d[j,1]) then
                begin
                        inc(d11);
                        dd[d[1,i]]:=false;
                end;
        crow:=0;
        for i:=1 to ctp do dd[i]:=true;
        for i:=1 to 1 shl k do
                if (d[1,i]<>-1) and (dd[d[1,i]]) then
                begin
                        inc(crow);
                        dd[d[1,i]]:=false;
                end;
        ccol:=0;
        for j:=1 to ctp do dd[j]:=true;
        for j:=1 to 1 shl k do
                if (d[j,1]<>-1) and (dd[d[j,1]]) then
                begin
                        inc(ccol);
                        dd[d[j,1]]:=false;
                end;
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=k+1 to n do
        begin
                ctp:=ctp*2-crow;
                ccol:=ccol*2-d11;
                ctp:=ctp*2-ccol;
                crow:=crow*2-d11;
        end;
        write(ctp);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Bfs;
        Init;
        Process;
        Close(input); Close(output);
End.
