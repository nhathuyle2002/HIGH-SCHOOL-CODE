Const   ginp='tigersugar.inp';
        gout='tigersugar.out';
        maxn=100010;
        oo=trunc(1e15);

Var     n,nd:longint;
        x1,y1,x2,y2,posx,posy:array[0..maxn] of longint;
        d:array[0..4*maxn] of longint;
        nheap:longint;
        heap:array[0..maxn] of longint;
        ix,iy:longint;
        sum,resx,resy:int64;
        rx,ry:array[0..maxn] of longint;

Procedure Swap(var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Sortd(l,r:longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sortd(l,j); sortd(i,r);
End;

Procedure Sort(l,r:longint; var a,b,p:array of longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        swap(p[i],p[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,a,b,p); sort(i,r,a,b,p);
End;

Procedure Upheap(i:longint);
Var     j:longint;
Begin
        j:=i div 2;
        if j<1 then exit;
        if heap[i]<heap[j] then
        begin
                swap(heap[i],heap[j]);
                upheap(j);
        end;
End;

Procedure Push(x:longint);
Begin
        inc(nheap);
        heap[nheap]:=x;
        upheap(nheap);
End;

Procedure Downheap(i:longint);
Var     j:longint;
Begin
        j:=i*2;
        if j>nheap then exit;
        if (j<nheap) and (heap[j+1]<heap[j]) then inc(j);
        if heap[j]<heap[i] then
        begin
                swap(heap[i],heap[j]);
                downheap(j);
        end;
End;

Procedure Pop;
Begin
        heap[1]:=heap[nheap];
        dec(nheap);
        downheap(1);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        nd:=0;
        for i:=1 to n do
        begin
                readln(x1[i],y1[i],x2[i],y2[i]);
                posx[i]:=i; posy[i]:=i;
                if x1[i]>x2[i] then swap(x1[i],x2[i]);
                if y1[i]>y2[i] then swap(y1[i],y2[i]);
                inc(nd); d[nd]:=x1[i];
                inc(nd); d[nd]:=y1[i];
                inc(nd); d[nd]:=x2[i];
                inc(nd); d[nd]:=y2[i];
        end;
        sortd(1,nd); d[0]:=d[1];
        sort(1,n,x1,x2,posx);
        sort(1,n,y1,y2,posy);
End;

Procedure Process1;
Var     i,j:longint;
Begin
        resx:=oo;
        for i:=1 to nd do
        begin
                sum:=0;
                for j:=1 to n do
                        if x2[j]<d[i] then sum:=sum+d[i]-x2[j] else
                        if x1[j]>d[i] then sum:=sum+x1[j]-d[i];
                if resx>sum then resx:=sum;
        end;
        resy:=oo;
        for i:=1 to nd do
        begin
                sum:=0;
                for j:=1 to n do
                        if y2[j]<d[i] then sum:=sum+d[i]-y2[j] else
                        if y1[j]>d[i] then sum:=sum+y1[j]-d[i];
                if resy>sum then resy:=sum;
        end;
        writeln(resx+resy);
End;

Procedure Processx;
Var     i,j,cou1,cou2:longint;
Begin
        sum:=0;
        for j:=1 to n do
                if x2[j]<d[0] then sum:=sum+d[0]-x2[j] else
                if x1[j]>d[0] then sum:=sum+x1[j]-d[0];
        resx:=sum; ix:=d[0];
        j:=1; nheap:=0;
        cou1:=0; cou2:=n;
        for i:=1 to nd do
        begin
                sum:=sum+int64(d[i]-d[i-1])*(cou1-cou2);
                while (nheap>0) and (heap[1]=d[i]) do
                begin
                        pop;
                        inc(cou1);
                end;
                while (j<=n) and (x1[j]=d[i]) do
                begin
                        push(x2[j]);
                        inc(j); dec(cou2);
                end;
                if resx>sum then
                begin
                        resx:=sum;
                        ix:=d[i];
                end;
        end;
        for i:=1 to n do
                if x2[i]<ix then rx[posx[i]]:=x2[i] else
                if x1[i]>ix then rx[posx[i]]:=x1[i] else
                rx[posx[i]]:=ix;
End;

Procedure Processy;
Var     i,j,cou1,cou2:longint;
Begin
        sum:=0;
        for j:=1 to n do
                if y2[j]<d[0] then sum:=sum+d[0]-y2[j] else
                if y1[j]>d[0] then sum:=sum+y1[j]-d[0];
        resy:=sum; iy:=d[0];
        j:=1; nheap:=0;
        cou1:=0; cou2:=n;
        for i:=1 to nd do
        begin
                sum:=sum+int64(d[i]-d[i-1])*(cou1-cou2);
                while (nheap>0) and (heap[1]=d[i]) do
                begin
                        pop;
                        inc(cou1);
                end;
                while (j<=n) and (y1[j]=d[i]) do
                begin
                        push(y2[j]);
                        inc(j); dec(cou2);
                end;
                if resy>sum then
                begin
                        resy:=sum;
                        iy:=d[i];
                end;
        end;
        for i:=1 to n do
                if y2[i]<iy then ry[posy[i]]:=y2[i] else
                if y1[i]>iy then ry[posy[i]]:=y1[i] else
                ry[posy[i]]:=iy;
End;

Procedure WriteAns;
Var     i:longint;
Begin
        writeln(resx+resy);
        writeln(ix,' ',iy);
        for i:=1 to n do writeln(rx[i],' ',ry[i]);
End;

Procedure Sinh;
Var     i,j:longint;
        Function R(x:longint):longint;
        Begin
                r:=random(x);
        End;
Begin
        Assign(output,ginp); Rewrite(output);
        randomize;
        n:=100000;
        writeln(n);
        for i:=1 to n do
        begin
                for j:=1 to 4 do write(r(trunc(1e9)),' ');
                writeln;
        end;
        Close(output);
End;

Begin
        //Sinh;
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        //Process1;
        Processx;
        Processy;
        WriteAns;
        Close(input); Close(output);
End.
