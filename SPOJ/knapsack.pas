const
	fi='knapsack.inp';
	fo='knapsack.out';

	maxN1=50;
	maxN2=trunc(1e3)+100;
	maxV=5*maxN1;
	maxW1=5000+100;

type obj=record
        m,v:longint;
	  end;

var
//Input
	n,w1,w2:longint;
	a:array[1..maxN1] of obj;
//DP
	f:array[0..maxN1,0..maxV,0..maxW1] of longint;
	trace:array[0..maxN1,0..maxV,0..maxW1] of obj;
//Greedy
	s1,s2:longint;
	pos:array[1..maxN2] of longint;
	avail:array[0..maxN2,0..maxW1] of longint;
//Res
	chose:array[1..maxN2] of longint;

Procedure Enter;
var i:longint;
Begin
	readln(n,w1,w2);
	for i:=1 to n do readln(a[i].m,a[i].v);
End;

Procedure PrintRes;
var i:longint;
Begin
	for i:=1 to n do write(chose[i],' ');
End;

Function min(a,b:longint):longint;
Begin
	if a=-1 then exit(b);
	if b=-1 then exit(a);
	if a<b then exit(a) else exit(b);
End;

Procedure Trace_back(i,j,k:longint);
var t:obj;
Begin
	while (i>0) do
	Begin
		t:=trace[i,j,k];
		if j=t.v then chose[i]:=0 else
		if k=t.m then chose[i]:=2 else
		              chose[i]:=1;
        dec(i);
        j:=t.v; k:=t.m;
	End;
End;

Procedure DP;
var i,j,k:longint;
Begin
	for j:=0 to 5*n do
	for k:=0 to w1 do f[0,j,k]:=-1;
	f[0,0,0]:=0;

	for i:=1 to n do
	for j:=0 to 5*n do
	for k:=0 to w1 do
	Begin
		f[i,j,k]:=f[i-1,j,k];
		trace[i,j,k].v:=j; trace[i,j,k].m:=k;

		if (j>=a[i].v) and (k>=a[i].m) and (min(f[i,j,k],f[i-1,j-a[i].v,k-a[i].m])=f[i-1,j-a[i].v,k-a[i].m]) then
		Begin
			f[i,j,k]:=f[i-1,j-a[i].v,k-a[i].m];
			trace[i,j,k].v:=j-a[i].v; trace[i,j,k].m:=k-a[i].m;
		End;

		if (j>=a[i].v) and (f[i-1,j-a[i].v,k]>=0) and (f[i-1,j-a[i].v,k]+a[i].m<=w2) and (min(f[i,j,k],f[i-1,j-a[i].v,k]+a[i].m)=f[i-1,j-a[i].v,k]+a[i].m) then
		Begin
			f[i,j,k]:=f[i-1,j-a[i].v,k]+a[i].m;
			trace[i,j,k].v:=j-a[i].v; trace[i,j,k].m:=k;
		End;
	End;

	for j:=5*n downto 0 do
	for k:=0 to w1 do
		if f[n,j,k]<>-1 then
		Begin
			Trace_back(n,j,k);
			exit;
		End;
End;

Procedure sort(l,r:longint);
var i,j:longint;
	pm,t_pos:longint;
	t_obj:obj;
Begin
	pm:=a[random(r-l+1)+l].m;
	i:=l; j:=r;

	repeat
		while a[i].m<pm do inc(i);
		while a[j].m>pm do dec(j);

		if i<=j then
		Begin
			t_obj:=a[i]; a[i]:=a[j]; a[j]:=t_obj;
			t_pos:=pos[i]; pos[i]:=pos[j]; pos[j]:=t_pos;
			inc(i);
			dec(j);
		End;
	until i>j;

	if i<r then sort(i,r);
	if l<j then sort(l,j);
End;

Procedure re_arrange(n:longint);
var i,j:longint;
Begin
	avail[0,0]:=0;
	for j:=1 to w1 do avail[0,j]:=-1;

	for i:=1 to n do
	for j:=0 to w1 do
	Begin
		if (avail[i-1,j]>=0) then avail[i,j]:=0 else avail[i,j]:=-1;
		if (j>=a[i].m) and (avail[i-1,j-a[i].m]>=0) then avail[i,j]:=1;
	End;

	for j:=w1 downto 0 do
		if avail[n,j]>=0 then break;

    s1:=0; s2:=0;
	for i:=n downto 1 do
        if avail[i,j]=1 then
        Begin
            s1:=s1+a[i].m;
            chose[pos[i]]:=1;
        End else
        Begin
            s2:=s2+a[i].m;
            chose[pos[i]]:=2;
        End;
End;

Procedure Greedy_DP;
var i:longint;
	added:boolean;
Begin
	for i:=1 to n do
    Begin
        pos[i]:=i;
        chose[i]:=0;
    End;
	a[n+1].m:=w2+1;
	sort(1,n);

	s1:=0; s2:=0;
	for i:=1 to n+1 do
		if s1+a[i].m>w1 then break else s1:=s1+a[i].m;

	repeat
		added:=false;
		while (i<=n) do
			if s2+a[i].m<=w2 then
			Begin
				added:=true;
				s2:=s2+a[i].m;
                                inc(i);
			End else break;

		re_arrange(i-1);
	until not added;
End;

Begin
	assign(input,fi); reset(input);
	assign(output,fo); rewrite(output);

	Enter;
	if (n<=maxN1) then DP else Greedy_DP;
	PrintRes;     readln;

	close(input);
	close(output);
End.
