Uses math;

Const fi='BOI2.INP';
      fo='BOI2.OUT';
      maxn=200100;
      oo=trunc(1e18);

Type gan=record
        x,y,c:int64;
     end;

Var m,n,i,max1:longint;
    A:array[1..maxn] of gan;
    Q:array[1..maxn] of array of gan;
    cha,B:array[0..maxn] of int64;
    L:array[1..30,1..30] of int64;

{--------------------------- doc file -------------------------------}

Procedure       doc;
   begin
      assign(input,fi); reset(input);
      assign(output,fo);        rewrite(output);
      readln(n,m);
      for i:=1 to m do readln(A[i].x,A[i].y,A[i].c);
   end;

{------------------------------- sub1 -------------------------------}

Function        mu(x:longint):int64;
   var j:longint;
   begin
      mu:=1;
      for j:=1 to x do mu:=mu*2;
   end;

Procedure       sub1;
   var i,j,k:longint;
       res:int64;

   Procedure    print1(x:int64);
      begin
         if x=0 then exit;
         print1(x div 2);
         write(x mod 2);
      end;

   begin
      for i:=1 to n do for j:=1 to n do L[i,j]:=oo;
      for i:=1 to n do L[i,i]:=0;
      for i:=1 to m do
      begin
         L[A[i].x,A[i].y]:=mu(A[i].c);
         L[A[i].y,A[i].x]:=mu(A[i].c);
      end;
      for k:=1 to n do
      for i:=1 to n do
      for j:=1 to n do L[i,j]:=min(L[i,j],L[i,k]+L[k,j]);
      res:=0;
      for i:=1 to n do
      for j:=i+1 to n do inc(res,L[i,j]);
      print1(res);
   end;

{------------------------- tim kruskal ------------------------------}

Procedure       qs(l,r:longint);
   var mid,d,e:longint;
       tmp:gan;
   begin
      d:=l; e:=r; mid:=A[(l+r) shr 1].c;
      repeat
         while A[d].c<mid do inc(d);
         while mid<A[e].c do dec(e);
         if d<=e then
         begin
            tmp:=A[d];
            A[d]:=A[e];
            A[e]:=tmp;
            inc(d); dec(e);
         end;
      until d>e;
      if d<r then qs(d,r);
      if l<e then qs(l,e);
   end;

Function        root(x:longint):longint;
   begin
      if cha[x]<>x then cha[x]:=root(cha[x]);
      exit(cha[x]);
   end;

Procedure       kruskal;
   var t1,t2:longint;
   begin
      qs(1,m);
      for i:=1 to n do cha[i]:=i;
      for i:=1 to m do
      begin
         t1:=root(A[i].x);
         t2:=root(A[i].y);
         if t1<>t2 then
         begin
            cha[t1]:=t2;
            Setlength(Q[A[i].x],length(Q[A[i].x])+1);
            Q[A[i].x,length(Q[A[i].x])-1].c:=A[i].c;
            Q[A[i].x,length(Q[A[i].x])-1].y:=A[i].y;
            Setlength(Q[A[i].y],length(Q[A[i].y])+1);
            Q[A[i].y,length(Q[A[i].y])-1].c:=A[i].c;
            Q[A[i].y,length(Q[A[i].y])-1].y:=A[i].x;
            max1:=max(max1,A[i].c);
         end;
      end;
   end;

{---------------------------- print ---------------------------------}

Procedure       print;
   begin
      for i:=1 to max1 do
      begin
         inc(B[i],B[i-1] div 2);
         B[i-1]:=B[i-1] mod 2;
      end;
      while B[max1]>1 do
      begin
         inc(B[max1+1],B[max1] div 2);
         B[max1]:=B[max1] mod 2;
         inc(max1);
      end;
      for i:=max1 downto 0 do write(B[i]);
   end;

{---------------------------- sub2 ----------------------------------}

Function        dfs2(x,fr:longint):int64;
   var i:longint;
       dem,k:int64;
   begin
      dem:=1;
      for i:=0 to length(Q[x])-1 do if Q[x,i].y<>fr then
      begin
         k:=dfs2(Q[x,i].y,x);
         inc(B[Q[x,i].c],k);
         inc(dem,k);
      end;
      exit(dem);
   end;

Procedure       sub2;
   var i:longint;
   begin
      kruskal;
      for i:=1 to n do dfs2(i,i);
      for i:=0 to max1 do B[i]:=B[i] div 2;
      print;
   end;

{---------------------------- sub3 ----------------------------------}


Function       dfs(x,fr:longint):int64;
   var i:longint;
       dem,k:int64;
   begin
      dem:=1;
      for i:=0 to length(Q[x])-1 do if Q[x,i].y<>fr then
      begin
         k:=dfs(Q[x,i].y,x);
         B[Q[x,i].c]:=k*(n-k);
         inc(dem,k);
      end;
      exit(dem);
   end;

Procedure       sub3;
   begin
      kruskal;
      dfs(1,1);
      print;
   end;

{-------------------------------------------------------------------}

BEGIN
   doc;
   if n<=30 then sub1 else
   if n<=1000 then sub2 else   sub3;
END.
