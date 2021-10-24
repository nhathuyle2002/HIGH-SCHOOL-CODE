Uses    Math;

Const   ginp='eureka.inp';
        gout='eureka.out';
        maxn=100010;
        base=123456789;
        mnt=47;

Type    bignum= array[1..mnt] of longint;
        save= record vl,vr,dl,dr:longint; end;

Var     n,top:longint;
        res:int64;
        nt:array[0..mnt] of longint;
        pos,d:array[0..201] of longint;
        a,st:array[0..3*maxn] of save;
        f:array[0..3*maxn] of bignum;

Procedure Init;
Var     i,j,nn:longint;
Begin
        fillchar(d,sizeof(d),0);
        nn:=0;
        for i:=2 to 200 do
                if d[i]=0 then
                begin
                        inc(nn); nt[nn]:=i;
                        pos[i]:=nn;
                        d[i]:=i;
                        for j:=i to 200 div i do d[i*j]:=i;
                end;
End;

Function Power(a,b:longint):int64;
Var     c:int64;
Begin
        if b=0 then exit(1);
        c:=power(a,b shr 1);
        power:=c*c mod base;
        if b and 1=1 then power:=power*a mod base;
End;

Function C_h(x:longint):bignum;
Begin
        fillchar(c_h,sizeof(c_h),0);
        while x>1 do
        begin
                inc(c_h[pos[d[x]]]);
                x:=x div d[x];
        end;
End;

Function Nhan(x,y:bignum):bignum;
Var     i:longint;
Begin
        for i:=1 to mnt do nhan[i]:=x[i]+y[i];
End;

Function Chia(x,y:bignum):bignum;
Var     i:longint;
Begin
        for i:=1 to mnt do chia[i]:=x[i]-y[i];
End;

Procedure Enter;
Var     i,cou:longint;
Begin
        readln(n);
        top:=1;
        i:=0; cou:=0;
        while cou<3*n+1 do
        begin
                inc(cou);
                inc(i);
                read(a[i].dl);
                if a[i].dl=-1 then
                begin
                        if st[top].dl=1 then a[st[top].vl].vl:=i else
                        if st[top].dr=1 then a[st[top].vr].vr:=i;
                        dec(top);
                        continue;
                end;
                inc(cou);
                read(a[i].dr);
                if st[top].dl=1 then a[st[top].vl].vl:=i else
                if st[top].dr=1 then a[st[top].vr].vr:=i;
                dec(top);
                inc(top);
                st[top].vr:=i; st[top].dr:=1;
                st[top].vl:=0; st[top].dl:=0;
                inc(top);
                st[top].vl:=i; st[top].dl:=1;
                st[top].vr:=0; st[top].dr:=0;
        end;
End;

Procedure Dfs(u:longint);
Var     i:longint;
        sl,sr:bignum;
Begin
        if a[u].dl=-1 then exit;
        dfs(a[u].vl);
        sl:=nhan(f[a[u].vl],c_h(a[u].dl));
        dfs(a[u].vr);
        sr:=nhan(f[a[u].vr],c_h(a[u].dr));
        for i:=1 to mnt do f[u,i]:=max(sl[i],sr[i]);
        f[u]:=chia(nhan(f[u],c_h(a[u].dl+a[u].dr)),nhan(c_h(a[u].dl),c_h(a[u].dr)));
End;

Procedure Process;
Var     i:longint;
Begin
        dfs(1);
        res:=1;
        for i:=1 to mnt do res:=res*power(nt[i],f[1,i]) mod base;
        write(res);
End;

Begin
        assign(input,ginp); assign(output,gout);
        reset(input); rewrite(output);
        Init;
        Enter;
        Process;
        close(input); close(output);
End.
