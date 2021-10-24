Const   ginp='paliny.inp';
        gout='paliny.out';
        modul = trunc(1e9)+13;
        base = 211;
        maxn = 50001;

Var     n,res:longint;
        a:ansistring;
        hl,hr,pow:array[0..maxn] of int64;

Function Get1(l,r:longint):int64;
Begin
        get1:=hl[r]-hl[l-1]*pow[r-l+1];
        get1:=(get1 mod modul+modul) mod modul;
End;

Function Get2(l,r:longint):int64;
Begin
        get2:=hr[l]-hr[r+1]*pow[r-l+1];
        get2:=(get2 mod modul+modul) mod modul;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        read(a);
        pow[0]:=1;
        for i:=1 to n do pow[i]:=pow[i-1]*base mod modul;
        hl[0]:=0;
        for i:=1 to n do hl[i]:=(hl[i-1]*base+ord(a[i])) mod modul;
        hr[n+1]:=0;
        for i:=n downto 1 do hr[i]:=(hr[i+1]*base+ord(a[i])) mod modul;
End;

Procedure Process;
Var     i,l,r,mid:longint;
        ok:boolean;
Begin
        l:=1; r:=n shr 1+1;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                ok:=false;
                for i:=mid to n-mid+1 do
                        if get1(i-mid+1,i) = get2(i,i+mid-1) then
                        begin
                                ok:=true;
                                break;
                        end;
                if ok then l:=mid+1 else r:=mid;
        end;
        res:=2*l-3;
        l:=1; r:=n shr 1+1;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                ok:=false;
                for i:=mid to n-mid do
                        if get1(i-mid+1,i) = get2(i+1,i+mid) then
                        begin
                                ok:=true;
                                break;
                        end;
                if ok then l:=mid+1 else r:=mid;
        end;
        if res<2*l-2 then res:=2*l-2;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
