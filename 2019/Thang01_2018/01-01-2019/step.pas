Uses    Math;

Const   ginp='step.inp';
        gout='step.out';
        maxn=100010;

Type    save= record g,la,ra,lb,rb,vl,vr:longint; end;

Var     n,q,cou:longint;
        f:array[0..4*maxn] of save;
        a,d,p,leaf:array[0..maxn] of longint;
        s:ansistring;

Procedure Sort(l,r:longint; var d,p:array of longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,p); sort(i,r,d,p);
End;

Procedure Build(id,l,r:longint);
Var     mid,i1,i2:longint;
Begin
        with f[id] do
        if l=r then
        begin
                g:=1;
                la:=1; ra:=1;
                lb:=0; rb:=0;
                vl:=d[l]; vr:=vl;
                leaf[l]:=id;
        end else
        begin
                mid:=(l+r) shr 1;
                i1:=id*2; i2:=id*2+1;
                build(i1,l,mid); build(i2,mid+1,r);
                vl:=f[i1].vl; vr:=f[i2].vr;
                g:=vr-vl+1;
                la:=vr-vl+1; ra:=vr-vl+1;
                lb:=0; rb:=0;
        end;
End;

Procedure Update(i:longint);
Var     i1,i2,id:longint;
Begin
        id:=i; i:=leaf[i];
        if s[id]='A' then s[id]:='B' else s[id]:='A';
        with f[i] do
        begin
                g:=1;
                if s[id]='A' then
                begin
                        la:=1; ra:=1;
                        lb:=1; rb:=1;
                end else
                begin
                        la:=0; ra:=0;
                        lb:=1; rb:=1;
                end;
        end;
        i:=i shr 1;
        while i>0 do
        begin
                i1:=i*2; i2:=i*2+1;
                f[i].g:=0;
                if f[i1].vr+1=f[i2].vl then
                begin
                        if f[i1].la=f[i1].vr-f[i1].vl+1 then f[i].la:=f[i1].la+f[i2].la else f[i].la:=f[i1].la;
                        if f[i2].ra=f[i2].vr-f[i2].vl+1 then f[i].ra:=f[i2].ra+f[i1].ra else f[i].ra:=f[i2].ra;
                        if f[i1].lb=f[i1].vr-f[i1].vl+1 then f[i].lb:=f[i1].lb+f[i2].lb else f[i].lb:=f[i1].lb;
                        if f[i2].rb=f[i2].vr-f[i2].vl+1 then f[i].rb:=f[i2].rb+f[i1].rb else f[i].rb:=f[i2].rb;
                        f[i].g:=max(f[i1].ra+f[i2].la,f[i1].rb+f[i2].lb);
                end else
                begin
                        if f[i1].la=f[i1].vr-f[i1].vl+1 then f[i].la:=f[i1].la+f[i2].la+f[i2].vl-f[i1].vr-1 else f[i].la:=f[i1].la;
                        if f[i2].ra=f[i2].vr-f[i2].vl+1 then f[i].ra:=f[i2].ra+f[i1].ra+f[i2].vl-f[i1].vr-1 else f[i].ra:=f[i2].ra;
                        f[i].lb:=f[i1].lb;
                        f[i].rb:=f[i2].rb;
                        f[i].g:=f[i1].ra+f[i2].la+f[i2].vl-f[i1].vr-1;
                end;
                f[i].g:=max(max(f[i].g,max(f[i1].g,f[i2].g)),max(max(f[i].la,f[i].ra),max(f[i].la,f[i].rb)));
                i:=i shr 1;
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,q);
        for i:=1 to q do readln(a[i]);
        a[q+1]:=1; a[q+2]:=n;
        for i:=1 to q+2 do
        begin
                d[i]:=a[i];
                p[i]:=i;
        end;
        sort(1,q+2,d,p);
        cou:=0;
        for i:=1 to q+2 do
        begin
                if d[i]>d[cou] then
                begin
                        inc(cou);
                        d[cou]:=d[i];
                end;
                a[p[i]]:=cou;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        s:='';
        for i:=1 to cou do s:=s+'A';
        build(1,1,cou);
        for i:=1 to q do
        begin
                update(a[i]);
                writeln(f[1].g);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.