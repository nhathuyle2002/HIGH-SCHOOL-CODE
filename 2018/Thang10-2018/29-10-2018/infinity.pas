Const   ginp='infinity.inp';
        gout='infinity.out';
        base=1000000000;
        mn=4;

Type    bignum= array[1..mn] of int64;

Var     q:longint;
        x,y:bignum;
        pos:int64;

Function Cmp(a,b:bignum):boolean;
Var     i:longint;
Begin
        for i:=mn downto 1 do
                if a[i]<>b[i] then exit(a[i]<b[i]);
        exit(false);
End;

Function Nhan(a,b:int64):bignum;
Var     i,j,nho:longint;
        aa,bb:bignum;
Begin
        aa[1]:=a mod base; aa[2]:=a div base;
        bb[1]:=b mod base; bb[2]:=b div base;
        for i:=1 to mn do nhan[i]:=0;
        for i:=1 to 2 do
                for j:=1 to 2 do nhan[i+j-1]:=nhan[i+j-1]+aa[i]*bb[j];
        nho:=0;
        for i:=1 to mn do
        begin
                nhan[i]:=nhan[i]+nho;
                nho:=nhan[i] div base;
                nhan[i]:=nhan[i] mod base;
        end;
End;

Function Tru(a,b:bignum):int64;
Var     i,nho:longint;
        t:bignum;
Begin
        nho:=0;
        for i:=1 to mn do
        begin
                t[i]:=a[i]-b[i]-nho;
                if t[i]<0 then
                begin
                        nho:=1;
                        t[i]:=t[i]+base;
                end
                else    nho:=0;
        end;
        tru:=0;
        for i:=mn downto 1 do tru:=tru*base+t[i];
End;

Procedure Enter;
Var     cou:longint;
        s:string[40];
Begin
        readln(s);
        cou:=0;
        fillchar(x,sizeof(x),0);
        while length(s)>9 do
        begin
                inc(cou);
                val(copy(s,length(s)-8,9),x[cou]);
                delete(s,length(s)-8,9);
        end;
        inc(cou);
        val(s,x[cou]);
End;

Procedure Process;
Var     l,r,mid:int64;
Begin
        l:=1; r:=trunc(1e16)+1;
        while l<r do
        begin
                mid:=(l+r) div 2;
                y:=nhan(mid,mid);
                if cmp(y,x) then l:=mid+1 else r:=mid;
        end;
        dec(l);
        pos:=tru(x,nhan(l,l));
        if pos<=l+1 then writeln(pos) else writeln(2*l-pos+2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(q);
        while q>0 do
        begin
                Enter;
                Process;
                dec(q);
        end;
        Close(input); Close(output);
End.
