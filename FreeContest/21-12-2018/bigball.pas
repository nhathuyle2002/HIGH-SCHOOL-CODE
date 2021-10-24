Const   ginp='bigball.inp';
        gout='bigball.out';
        mn=5;
        base=trunc(1e8);

Type    point= record x,y,z:int64; end;
        bignum= array[1..mn] of int64;

Var     n:longint;
        a,b,c,u,v,t:point;
        res:extended;
        tx,ty,tz,ux:bignum;

Procedure Enter;
Begin
        readln(n);
        readln(a.x,a.y,a.z);
        readln(b.x,b.y,b.z);
End;

Function Doi(x:int64):bignum;
Var     i:longint;
Begin
        fillchar(doi,sizeof(doi),0);
        i:=0;
        while x>0 do
        begin
                inc(i);
                doi[i]:=x mod base;
                x:=x div base;
        end;
End;

Function Cmp(a,b:bignum):boolean; // a<=b //
Var     i:longint;
Begin
        for i:=mn downto 1 do
                if a[i]<b[i] then exit(true) else
                if a[i]>b[i] then exit(false);
        exit(true);
End;

Function Cong(a,b:bignum):bignum;
Var     i:longint;
        nho:int64;
Begin
        nho:=0;
        for i:=1 to mn do
        begin
                cong[i]:=a[i]+b[i]+nho;
                nho:=cong[i] div base;
                cong[i]:=cong[i] mod base;
        end;
End;

Function Nhan(a,b:bignum):bignum;
Var     i,j:longint;
        nho:int64;
Begin
        fillchar(nhan,sizeof(nhan),0);
        for i:=1 to mn do
                for j:=1 to mn-i+1 do
                        nhan[i+j-1]:=nhan[i+j-1]+a[i]*b[j];
        nho:=0;
        for i:=1 to mn do
        begin
                nhan[i]:=nhan[i]+nho;
                nho:=nhan[i] div base;
                nhan[i]:=nhan[i] mod base;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        u.x:=a.x-b.x; u.y:=a.y-b.y; u.z:=a.z-b.z;
        for i:=1 to n do
        begin
                readln(c.x,c.y,c.z);
                v.x:=a.x-c.x; v.y:=a.y-c.y; v.z:=a.z-c.z;
                t.x:=u.y*v.z-u.z*v.y;
                t.y:=u.z*v.x-u.x*v.z;
                t.z:=u.x*v.y-u.y*v.x;
                res:=sqrt((t.x*t.x+t.y*t.y+t.z*t.z)/(u.x*u.x+u.y*u.y+u.z*u.z));
                if trunc(res)=res then writeln(trunc(res)) else writeln(trunc(res)+1);
        end;
End;

Procedure Process2;
Var     i:longint;
        l,r,mid:int64;
Begin
        u.x:=a.x-b.x; u.y:=a.y-b.y; u.z:=a.z-b.z;
        for i:=1 to n do
        begin
                readln(c.x,c.y,c.z);
                v.x:=a.x-c.x; v.y:=a.y-c.y; v.z:=a.z-c.z;
                t.x:=u.y*v.z-u.z*v.y;
                t.y:=u.z*v.x-u.x*v.z;
                t.z:=u.x*v.y-u.y*v.x;
                tx:=doi(abs(t.x)); ty:=doi(abs(t.y)); tz:=doi(abs(t.z));
                tx:=cong(nhan(tx,tx),cong(nhan(ty,ty),nhan(tz,tz)));
                ux:=doi(u.x*u.x+u.y*u.y+u.z*u.z);
                l:=0; r:=trunc(1e16);
                while l<r do
                begin
                        mid:=(l+r) div 2;
                        if cmp(tx,nhan(doi(mid),nhan(doi(mid),ux))) then r:=mid else l:=mid+1;
                end;
                writeln(l);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process2;
        Close(input); Close(output);
End.
