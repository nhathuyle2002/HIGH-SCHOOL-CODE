const   fi  ='latxu.INP';
        fo  ='latxu.OUT';
var     i,n: longint;
        a,pre: array[0..1000006] of longint;

procedure main;
var     sl,i: longint;
begin
        sl:= 0; pre[0]:=1;
        for i:=1 to n do
        begin
                sl:=sl+1-a[i];
                if i mod 2 = 1 then
                begin
                        if a[i]=a[i-1] then pre[i]:=pre[i-1] else pre[i]:=i;
                end
                else
                begin
                        if a[i]<>a[i-1] then
                        begin
                                if a[pre[i-1]] = 1 then sl:= sl+i-pre[i-1] else sl:=sl-i+pre[i-1];
                                pre[i]:=pre[pre[i-1]-1];
                                a[pre[i-1]]:=a[i];
                        end else pre[i]:=pre[i-1] ;
                end;
        end;
        write(sl);
end;

begin
        assign(input,fi);  assign(output,fo);
        reset(input);      rewrite(output);
        readln(n);
        for i:=1 to n do read(a[i]);
        main;
        close(input);      close(output);
end.

