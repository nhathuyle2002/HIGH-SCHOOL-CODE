Const   ginp='cntab2.inp';
        gout='cntab2.out';
        maxn=101;

Var     n,nn,ca,cb:longint;
        a,b,aa,bb:array[0..maxn,0..maxn] of longint;
        pr,pc,prow,pcol,d:array[0..maxn] of longint;
        ok:boolean;
        ox,oy:array[1..2,0..maxn*maxn*maxn] of longint;

Procedure Swap(var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Swaprw(i1,i2,typ:longint);
Var     j:longint;
Begin
        swap(pr[i1],pr[i2]);
        if typ=1 then
                for j:=1 to n do swap(a[i1,j],a[i2,j]) else
        if typ=2 then
                for j:=1 to n do swap(b[i1,j],b[i2,j]);
End;

Procedure Swapcl(j1,j2,typ:longint);
Var     i:longint;
Begin
        swap(pc[j1],pc[j2]);
        if typ=1 then
                for i:=1 to n do swap(a[i,j1],a[i,j2]);
        if typ=2 then
                for i:=1 to n do swap(b[i,j1],b[i,j2]);
End;

Function Findrw(jj,typ:longint):longint;
Var     i:longint;
Begin
        if typ=1 then
        for i:=1 to n do
                if a[i,jj]=1 then exit(i);
        if typ=2 then
        for i:=1 to n do
                if b[i,jj]=1 then exit(i);
End;

Function Findcl(ii,typ:longint):longint;
Var     j:longint;
Begin
        if typ=1 then
        for j:=1 to n do
                if a[ii,j]=-1 then exit(j);
        if typ=2 then
        for j:=1 to n do
                if b[ii,j]=-1 then exit(j);
End;

Procedure Sort(l,r:longint; var p1,p2,d:array of longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while t<d[j] do dec(j);
                if i<=j then
                begin
                        swap(p1[i],p1[j]); swap(p2[i],p2[j]);
                        swap(d[i],d[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,p1,p2,d); sort(i,r,p1,p2,d);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to n do read(aa[i,j]);
                readln;
        end;
        for i:=1 to n do
        begin
                for j:=1 to n do read(bb[i,j]);
                readln;
        end;
End;

Procedure Processa;
Var     i,j,k,pos,kk,jj:longint;
Begin
        for i:=1 to n do
        begin
                pr[i]:=i; pc[i]:=i;
        end;
        a:=aa; nn:=0;
        for k:=1 to n do
        begin
                i:=findrw(k,1);
                if i>k then swaprw(i,k,1);
                j:=findcl(k,1);
                if j>k+1 then swapcl(k+1,j,1);
        end;

        for i:=1 to n do
                if a[i-1,i]<>-1 then
                begin
                        inc(nn);
                        prow[nn]:=pr[i]; pcol[nn]:=pc[i];
                        d[nn]:=i;
                end;
        d[nn+1]:=n+1;
        for i:=1 to nn do d[i]:=d[i+1]-d[i];
        sort(1,nn,prow,pcol,d);

        a:=aa; ca:=0;
        for i:=1 to n do
        begin
                pr[i]:=i; pc[i]:=i;
        end;
        kk:=1; pos:=1;
        for k:=1 to n do
        begin
                if k=pos then
                begin
                        for jj:=1 to n do
                                if pc[jj]=pcol[kk] then break;
                        if jj<>k then
                        begin
                                inc(ca);
                                ox[1,ca]:=-jj; oy[1,ca]:=-k;
                                swapcl(jj,k,1);
                        end;
                        pos:=pos+d[kk];
                        inc(kk);
                end;
                i:=findrw(k,1);
                if i>k then
                begin
                        inc(ca);
                        ox[1,ca]:=i; oy[1,ca]:=k;
                        swaprw(i,k,1);
                end;
                j:=findcl(k,1);
                if j>k+1 then
                begin
                        inc(ca);
                        ox[1,ca]:=-j; oy[1,ca]:=-k-1;
                        swapcl(j,k+1,1);
                end;
        end;
End;

Procedure Processb;
Var     i,j,k,pos,kk,jj:longint;
Begin
        for i:=1 to n do
        begin
                pr[i]:=i; pc[i]:=i;
        end;
        b:=bb; nn:=0;
        for k:=1 to n do
        begin
                i:=findrw(k,2);
                if i>k then swaprw(i,k,2);
                j:=findcl(k,2);
                if j>k+1 then swapcl(k+1,j,2);
        end;

        for i:=1 to n do
                if b[i-1,i]<>-1 then
                begin
                        inc(nn);
                        prow[nn]:=pr[i]; pcol[nn]:=pc[i];
                        d[nn]:=i;
                end;
        d[nn+1]:=n+1;
        for i:=1 to nn do d[i]:=d[i+1]-d[i];
        sort(1,nn,prow,pcol,d);

        b:=bb; cb:=0;
        for i:=1 to n do
        begin
                pr[i]:=i; pc[i]:=i;
        end;
        kk:=1; pos:=1;
        for k:=1 to n do
        begin
                if k=pos then
                begin
                        for jj:=1 to n do
                                if pc[jj]=pcol[kk] then break;
                        if jj<>k then
                        begin
                                inc(cb);
                                ox[2,cb]:=-jj; oy[2,cb]:=-k;
                                swapcl(jj,k,2);
                        end;
                        pos:=pos+d[kk];
                        inc(kk);
                end;
                i:=findrw(k,2);
                if i>k then
                begin
                        inc(cb);
                        ox[2,cb]:=i; oy[2,cb]:=k;
                        swaprw(i,k,2);
                end;
                j:=findcl(k,2);
                if j>k+1 then
                begin
                        inc(cb);
                        ox[2,cb]:=-j; oy[2,cb]:=-k-1;
                        swapcl(j,k+1,2);
                end;
        end;
End;

Procedure WriteAns;
Var     i,j:longint;
Begin
        ok:=true;
        for i:=1 to n do
                for j:=1 to n do
                        if a[i,j]<>b[i,j] then ok:=false;
        if not ok then write(-1) else
        begin
                writeln(ca+cb);
                for i:=1 to ca do
                        if ox[1,i]>0 then writeln('1 ',ox[1,i],' ',oy[1,i]) else writeln('2 ',-ox[1,i],' ',-oy[1,i]);
                for i:=cb downto 1 do
                        if ox[2,i]>0 then writeln('1 ',ox[2,i],' ',oy[2,i]) else writeln('2 ',-ox[2,i],' ',-oy[2,i]);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Processa;
        Processb;
        WriteAns;
        Close(input); Close(output);
End.
