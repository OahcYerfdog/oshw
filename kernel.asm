
kernel：     檔案格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 2e 10 80       	mov    $0x80102e60,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 c0 70 10 80       	push   $0x801070c0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 e5 42 00 00       	call   80104340 <initlock>
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
80100092:	68 c7 70 10 80       	push   $0x801070c7
80100097:	50                   	push   %eax
80100098:	e8 93 41 00 00       	call   80104230 <initsleeplock>
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 57 43 00 00       	call   80104440 <acquire>
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 f9 43 00 00       	call   80104560 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 40 00 00       	call   80104270 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 6d 1f 00 00       	call   801020f0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ce 70 10 80       	push   $0x801070ce
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 41 00 00       	call   80104310 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
801001c4:	e9 27 1f 00 00       	jmp    801020f0 <iderw>
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 df 70 10 80       	push   $0x801070df
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 41 00 00       	call   80104310 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 40 00 00       	call   801042d0 <releasesleep>
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 30 42 00 00       	call   80104440 <acquire>
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100213:	83 c4 10             	add    $0x10,%esp
80100216:	83 e8 01             	sub    $0x1,%eax
80100219:	85 c0                	test   %eax,%eax
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
8010025c:	e9 ff 42 00 00       	jmp    80104560 <release>
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 e6 70 10 80       	push   $0x801070e6
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010027f:	57                   	push   %edi
80100280:	e8 cb 14 00 00       	call   80101750 <iunlock>
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 af 41 00 00       	call   80104440 <acquire>
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
801002a1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002a6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 a0 ff 10 80       	push   $0x8010ffa0
801002bd:	e8 fe 3a 00 00       	call   80103dc0 <sleep>
801002c2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
801002d2:	e8 b9 34 00 00       	call   80103790 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 a5 10 80       	push   $0x8010a520
801002e6:	e8 75 42 00 00       	call   80104560 <release>
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 7d 13 00 00       	call   80101670 <ilock>
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%edx
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
80100322:	83 c6 01             	add    $0x1,%esi
80100325:	83 eb 01             	sub    $0x1,%ebx
80100328:	83 fa 0a             	cmp    $0xa,%edx
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 15 42 00 00       	call   80104560 <release>
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 1d 13 00 00       	call   80101670 <ilock>
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
80100360:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
80100378:	fa                   	cli    
80100379:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100380:	00 00 00 
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100389:	e8 62 23 00 00       	call   801026f0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 ed 70 10 80       	push   $0x801070ed
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
801003a5:	c7 04 24 bf 7a 10 80 	movl   $0x80107abf,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 a3 3f 00 00       	call   80104360 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 01 71 10 80       	push   $0x80107101
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
801003d9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 61 58 00 00       	call   80105c80 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
80100437:	0f b6 c0             	movzbl %al,%eax
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 a8 57 00 00       	call   80105c80 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 9c 57 00 00       	call   80105c80 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 90 57 00 00       	call   80105c80 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>
801004f8:	83 ec 04             	sub    $0x4,%esp
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
80100514:	e8 47 41 00 00       	call   80104660 <memmove>
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 82 40 00 00       	call   801045b0 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 05 71 10 80       	push   $0x80107105
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
8010058b:	85 c9                	test   %ecx,%ecx
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 30 71 10 80 	movzbl -0x7fef8ed0(%edx),%edx
801005b8:	85 c0                	test   %eax,%eax
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	ff 75 08             	pushl  0x8(%ebp)
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
8010060f:	e8 3c 11 00 00       	call   80101750 <iunlock>
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 20 3e 00 00       	call   80104440 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 14 3f 00 00       	call   80104560 <release>
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 1b 10 00 00       	call   80101670 <ilock>
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
8010066e:	85 c0                	test   %eax,%eax
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 a5 10 80       	push   $0x8010a520
8010070d:	e8 4e 3e 00 00       	call   80104560 <release>
80100712:	83 c4 10             	add    $0x10,%esp
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100788:	b8 18 71 10 80       	mov    $0x80107118,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 a5 10 80       	push   $0x8010a520
801007c8:	e8 73 3c 00 00       	call   80104440 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 1f 71 10 80       	push   $0x8010711f
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
801007f6:	31 f6                	xor    %esi,%esi
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
801007fe:	68 20 a5 10 80       	push   $0x8010a520
80100803:	e8 38 3c 00 00       	call   80104440 <acquire>
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
80100831:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100836:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 a5 10 80       	push   $0x8010a520
80100868:	e8 f3 3c 00 00       	call   80104560 <release>
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
801008a5:	83 ff 0d             	cmp    $0xd,%edi
801008a8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
801008e9:	83 ec 0c             	sub    $0xc,%esp
801008ec:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
801008f1:	68 a0 ff 10 80       	push   $0x8010ffa0
801008f6:	e8 75 36 00 00       	call   80103f70 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100908:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010090d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100920:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
8010092f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100934:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
80100948:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
80100977:	e9 e4 36 00 00       	jmp    80104060 <procdump>
8010097c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
801009a6:	68 28 71 10 80       	push   $0x80107128
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 8b 39 00 00       	call   80104340 <initlock>
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
801009bb:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009c2:	06 10 80 
801009c5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009cc:	02 10 80 
801009cf:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009d6:	00 00 00 
801009d9:	e8 c2 18 00 00       	call   801022a0 <ioapicenable>
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	c9                   	leave  
801009e2:	c3                   	ret    
801009e3:	66 90                	xchg   %ax,%ax
801009e5:	66 90                	xchg   %ax,%ax
801009e7:	66 90                	xchg   %ax,%ax
801009e9:	66 90                	xchg   %ax,%ax
801009eb:	66 90                	xchg   %ax,%ax
801009ed:	66 90                	xchg   %ax,%ax
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009fc:	e8 8f 2d 00 00       	call   80103790 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a07:	e8 44 21 00 00       	call   80102b50 <begin_op>

  if((ip = namei(path)) == 0){
80100a0c:	83 ec 0c             	sub    $0xc,%esp
80100a0f:	ff 75 08             	pushl  0x8(%ebp)
80100a12:	e8 a9 14 00 00       	call   80101ec0 <namei>
80100a17:	83 c4 10             	add    $0x10,%esp
80100a1a:	85 c0                	test   %eax,%eax
80100a1c:	0f 84 9c 01 00 00    	je     80100bbe <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a22:	83 ec 0c             	sub    $0xc,%esp
80100a25:	89 c3                	mov    %eax,%ebx
80100a27:	50                   	push   %eax
80100a28:	e8 43 0c 00 00       	call   80101670 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	6a 34                	push   $0x34
80100a35:	6a 00                	push   $0x0
80100a37:	50                   	push   %eax
80100a38:	53                   	push   %ebx
80100a39:	e8 12 0f 00 00       	call   80101950 <readi>
80100a3e:	83 c4 20             	add    $0x20,%esp
80100a41:	83 f8 34             	cmp    $0x34,%eax
80100a44:	74 22                	je     80100a68 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 b1 0e 00 00       	call   80101900 <iunlockput>
    end_op();
80100a4f:	e8 6c 21 00 00       	call   80102bc0 <end_op>
80100a54:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5f:	5b                   	pop    %ebx
80100a60:	5e                   	pop    %esi
80100a61:	5f                   	pop    %edi
80100a62:	5d                   	pop    %ebp
80100a63:	c3                   	ret    
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a6f:	45 4c 46 
80100a72:	75 d2                	jne    80100a46 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a74:	e8 97 63 00 00       	call   80106e10 <setupkvm>
80100a79:	85 c0                	test   %eax,%eax
80100a7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a81:	74 c3                	je     80100a46 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a83:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a8a:	00 
80100a8b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a91:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a98:	00 00 00 
80100a9b:	0f 84 c5 00 00 00    	je     80100b66 <exec+0x176>
80100aa1:	31 ff                	xor    %edi,%edi
80100aa3:	eb 18                	jmp    80100abd <exec+0xcd>
80100aa5:	8d 76 00             	lea    0x0(%esi),%esi
80100aa8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aaf:	83 c7 01             	add    $0x1,%edi
80100ab2:	83 c6 20             	add    $0x20,%esi
80100ab5:	39 f8                	cmp    %edi,%eax
80100ab7:	0f 8e a9 00 00 00    	jle    80100b66 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100abd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ac3:	6a 20                	push   $0x20
80100ac5:	56                   	push   %esi
80100ac6:	50                   	push   %eax
80100ac7:	53                   	push   %ebx
80100ac8:	e8 83 0e 00 00       	call   80101950 <readi>
80100acd:	83 c4 10             	add    $0x10,%esp
80100ad0:	83 f8 20             	cmp    $0x20,%eax
80100ad3:	75 7b                	jne    80100b50 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ad5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adc:	75 ca                	jne    80100aa8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ade:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aea:	72 64                	jb     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100aec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af2:	72 5c                	jb     80100b50 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100af4:	83 ec 04             	sub    $0x4,%esp
80100af7:	50                   	push   %eax
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b04:	e8 57 61 00 00       	call   80106c60 <allocuvm>
80100b09:	83 c4 10             	add    $0x10,%esp
80100b0c:	85 c0                	test   %eax,%eax
80100b0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b14:	74 3a                	je     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b21:	75 2d                	jne    80100b50 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b23:	83 ec 0c             	sub    $0xc,%esp
80100b26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b32:	53                   	push   %ebx
80100b33:	50                   	push   %eax
80100b34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b3a:	e8 61 60 00 00       	call   80106ba0 <loaduvm>
80100b3f:	83 c4 20             	add    $0x20,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	0f 89 5e ff ff ff    	jns    80100aa8 <exec+0xb8>
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b59:	e8 32 62 00 00       	call   80106d90 <freevm>
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	e9 e0 fe ff ff       	jmp    80100a46 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b66:	83 ec 0c             	sub    $0xc,%esp
80100b69:	53                   	push   %ebx
80100b6a:	e8 91 0d 00 00       	call   80101900 <iunlockput>
  end_op();
80100b6f:	e8 4c 20 00 00       	call   80102bc0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b8d:	52                   	push   %edx
80100b8e:	50                   	push   %eax
80100b8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b95:	e8 c6 60 00 00       	call   80106c60 <allocuvm>
80100b9a:	83 c4 10             	add    $0x10,%esp
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	89 c6                	mov    %eax,%esi
80100ba1:	75 3a                	jne    80100bdd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ba3:	83 ec 0c             	sub    $0xc,%esp
80100ba6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bac:	e8 df 61 00 00       	call   80106d90 <freevm>
80100bb1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb9:	e9 9e fe ff ff       	jmp    80100a5c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bbe:	e8 fd 1f 00 00       	call   80102bc0 <end_op>
    cprintf("exec: fail\n");
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 41 71 10 80       	push   $0x80107141
80100bcb:	e8 90 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd8:	e9 7f fe ff ff       	jmp    80100a5c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bdd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	31 ff                	xor    %edi,%edi
80100be8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bea:	50                   	push   %eax
80100beb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bf1:	e8 ba 62 00 00       	call   80106eb0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c02:	8b 00                	mov    (%eax),%eax
80100c04:	85 c0                	test   %eax,%eax
80100c06:	74 79                	je     80100c81 <exec+0x291>
80100c08:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c0e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c14:	eb 13                	jmp    80100c29 <exec+0x239>
80100c16:	8d 76 00             	lea    0x0(%esi),%esi
80100c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	0f 84 7a ff ff ff    	je     80100ba3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	50                   	push   %eax
80100c2d:	e8 be 3b 00 00       	call   801047f0 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 ab 3b 00 00       	call   801047f0 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 ba 63 00 00       	call   80107010 <copyout>
80100c56:	83 c4 20             	add    $0x20,%esp
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 42 ff ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c61:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c77:	85 c0                	test   %eax,%eax
80100c79:	75 a5                	jne    80100c20 <exec+0x230>
80100c7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c88:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c91:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c9c:	ff ff ff 
  ustack[1] = argc;
80100c9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100ca7:	83 c0 0c             	add    $0xc,%eax
80100caa:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cac:	50                   	push   %eax
80100cad:	52                   	push   %edx
80100cae:	53                   	push   %ebx
80100caf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	e8 50 63 00 00       	call   80107010 <copyout>
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	85 c0                	test   %eax,%eax
80100cc5:	0f 88 d8 fe ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cce:	0f b6 10             	movzbl (%eax),%edx
80100cd1:	84 d2                	test   %dl,%dl
80100cd3:	74 19                	je     80100cee <exec+0x2fe>
80100cd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cd8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cdb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cde:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ce1:	0f 44 c8             	cmove  %eax,%ecx
80100ce4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ce7:	84 d2                	test   %dl,%dl
80100ce9:	75 f0                	jne    80100cdb <exec+0x2eb>
80100ceb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cf4:	50                   	push   %eax
80100cf5:	6a 10                	push   $0x10
80100cf7:	ff 75 08             	pushl  0x8(%ebp)
80100cfa:	89 f8                	mov    %edi,%eax
80100cfc:	83 c0 6c             	add    $0x6c,%eax
80100cff:	50                   	push   %eax
80100d00:	e8 ab 3a 00 00       	call   801047b0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d0b:	89 f8                	mov    %edi,%eax
80100d0d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d10:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d12:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d15:	89 c1                	mov    %eax,%ecx
80100d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1d:	8b 40 18             	mov    0x18(%eax),%eax
80100d20:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d23:	8b 41 18             	mov    0x18(%ecx),%eax
80100d26:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d29:	89 0c 24             	mov    %ecx,(%esp)
80100d2c:	e8 df 5c 00 00       	call   80106a10 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 57 60 00 00       	call   80106d90 <freevm>
  return 0;
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	31 c0                	xor    %eax,%eax
80100d3e:	e9 19 fd ff ff       	jmp    80100a5c <exec+0x6c>
80100d43:	66 90                	xchg   %ax,%ax
80100d45:	66 90                	xchg   %ax,%ax
80100d47:	66 90                	xchg   %ax,%ax
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 10             	sub    $0x10,%esp
80100d56:	68 4d 71 10 80       	push   $0x8010714d
80100d5b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d60:	e8 db 35 00 00       	call   80104340 <initlock>
80100d65:	83 c4 10             	add    $0x10,%esp
80100d68:	c9                   	leave  
80100d69:	c3                   	ret    
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <filealloc>:
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
80100d74:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
80100d79:	83 ec 10             	sub    $0x10,%esp
80100d7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d81:	e8 ba 36 00 00       	call   80104440 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 10                	jmp    80100d9b <filealloc+0x2b>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
80100da2:	83 ec 0c             	sub    $0xc,%esp
80100da5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80100dac:	68 c0 ff 10 80       	push   $0x8010ffc0
80100db1:	e8 aa 37 00 00       	call   80104560 <release>
80100db6:	89 d8                	mov    %ebx,%eax
80100db8:	83 c4 10             	add    $0x10,%esp
80100dbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dbe:	c9                   	leave  
80100dbf:	c3                   	ret    
80100dc0:	83 ec 0c             	sub    $0xc,%esp
80100dc3:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc8:	e8 93 37 00 00       	call   80104560 <release>
80100dcd:	83 c4 10             	add    $0x10,%esp
80100dd0:	31 c0                	xor    %eax,%eax
80100dd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dd5:	c9                   	leave  
80100dd6:	c3                   	ret    
80100dd7:	89 f6                	mov    %esi,%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <filedup>:
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 10             	sub    $0x10,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100dea:	68 c0 ff 10 80       	push   $0x8010ffc0
80100def:	e8 4c 36 00 00       	call   80104440 <acquire>
80100df4:	8b 43 04             	mov    0x4(%ebx),%eax
80100df7:	83 c4 10             	add    $0x10,%esp
80100dfa:	85 c0                	test   %eax,%eax
80100dfc:	7e 1a                	jle    80100e18 <filedup+0x38>
80100dfe:	83 c0 01             	add    $0x1,%eax
80100e01:	83 ec 0c             	sub    $0xc,%esp
80100e04:	89 43 04             	mov    %eax,0x4(%ebx)
80100e07:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0c:	e8 4f 37 00 00       	call   80104560 <release>
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 54 71 10 80       	push   $0x80107154
80100e20:	e8 4b f5 ff ff       	call   80100370 <panic>
80100e25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 28             	sub    $0x28,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
80100e3c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e41:	e8 fa 35 00 00       	call   80104440 <acquire>
80100e46:	8b 47 04             	mov    0x4(%edi),%eax
80100e49:	83 c4 10             	add    $0x10,%esp
80100e4c:	85 c0                	test   %eax,%eax
80100e4e:	0f 8e 9b 00 00 00    	jle    80100eef <fileclose+0xbf>
80100e54:	83 e8 01             	sub    $0x1,%eax
80100e57:	85 c0                	test   %eax,%eax
80100e59:	89 47 04             	mov    %eax,0x4(%edi)
80100e5c:	74 1a                	je     80100e78 <fileclose+0x48>
80100e5e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
80100e65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e68:	5b                   	pop    %ebx
80100e69:	5e                   	pop    %esi
80100e6a:	5f                   	pop    %edi
80100e6b:	5d                   	pop    %ebp
80100e6c:	e9 ef 36 00 00       	jmp    80104560 <release>
80100e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e78:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e7c:	8b 1f                	mov    (%edi),%ebx
80100e7e:	83 ec 0c             	sub    $0xc,%esp
80100e81:	8b 77 0c             	mov    0xc(%edi),%esi
80100e84:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80100e8a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e8d:	8b 47 10             	mov    0x10(%edi),%eax
80100e90:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e95:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100e98:	e8 c3 36 00 00       	call   80104560 <release>
80100e9d:	83 c4 10             	add    $0x10,%esp
80100ea0:	83 fb 01             	cmp    $0x1,%ebx
80100ea3:	74 13                	je     80100eb8 <fileclose+0x88>
80100ea5:	83 fb 02             	cmp    $0x2,%ebx
80100ea8:	74 26                	je     80100ed0 <fileclose+0xa0>
80100eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ead:	5b                   	pop    %ebx
80100eae:	5e                   	pop    %esi
80100eaf:	5f                   	pop    %edi
80100eb0:	5d                   	pop    %ebp
80100eb1:	c3                   	ret    
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100eb8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ebc:	83 ec 08             	sub    $0x8,%esp
80100ebf:	53                   	push   %ebx
80100ec0:	56                   	push   %esi
80100ec1:	e8 2a 24 00 00       	call   801032f0 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ed0:	e8 7b 1c 00 00       	call   80102b50 <begin_op>
80100ed5:	83 ec 0c             	sub    $0xc,%esp
80100ed8:	ff 75 e0             	pushl  -0x20(%ebp)
80100edb:	e8 c0 08 00 00       	call   801017a0 <iput>
80100ee0:	83 c4 10             	add    $0x10,%esp
80100ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee6:	5b                   	pop    %ebx
80100ee7:	5e                   	pop    %esi
80100ee8:	5f                   	pop    %edi
80100ee9:	5d                   	pop    %ebp
80100eea:	e9 d1 1c 00 00       	jmp    80102bc0 <end_op>
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 5c 71 10 80       	push   $0x8010715c
80100ef7:	e8 74 f4 ff ff       	call   80100370 <panic>
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f00 <filestat>:
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	53                   	push   %ebx
80100f04:	83 ec 04             	sub    $0x4,%esp
80100f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f0d:	75 31                	jne    80100f40 <filestat+0x40>
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	ff 73 10             	pushl  0x10(%ebx)
80100f15:	e8 56 07 00 00       	call   80101670 <ilock>
80100f1a:	58                   	pop    %eax
80100f1b:	5a                   	pop    %edx
80100f1c:	ff 75 0c             	pushl  0xc(%ebp)
80100f1f:	ff 73 10             	pushl  0x10(%ebx)
80100f22:	e8 f9 09 00 00       	call   80101920 <stati>
80100f27:	59                   	pop    %ecx
80100f28:	ff 73 10             	pushl  0x10(%ebx)
80100f2b:	e8 20 08 00 00       	call   80101750 <iunlock>
80100f30:	83 c4 10             	add    $0x10,%esp
80100f33:	31 c0                	xor    %eax,%eax
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f50 <fileread>:
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	57                   	push   %edi
80100f54:	56                   	push   %esi
80100f55:	53                   	push   %ebx
80100f56:	83 ec 0c             	sub    $0xc,%esp
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f5f:	8b 7d 10             	mov    0x10(%ebp),%edi
80100f62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f66:	74 60                	je     80100fc8 <fileread+0x78>
80100f68:	8b 03                	mov    (%ebx),%eax
80100f6a:	83 f8 01             	cmp    $0x1,%eax
80100f6d:	74 41                	je     80100fb0 <fileread+0x60>
80100f6f:	83 f8 02             	cmp    $0x2,%eax
80100f72:	75 5b                	jne    80100fcf <fileread+0x7f>
80100f74:	83 ec 0c             	sub    $0xc,%esp
80100f77:	ff 73 10             	pushl  0x10(%ebx)
80100f7a:	e8 f1 06 00 00       	call   80101670 <ilock>
80100f7f:	57                   	push   %edi
80100f80:	ff 73 14             	pushl  0x14(%ebx)
80100f83:	56                   	push   %esi
80100f84:	ff 73 10             	pushl  0x10(%ebx)
80100f87:	e8 c4 09 00 00       	call   80101950 <readi>
80100f8c:	83 c4 20             	add    $0x20,%esp
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	89 c6                	mov    %eax,%esi
80100f93:	7e 03                	jle    80100f98 <fileread+0x48>
80100f95:	01 43 14             	add    %eax,0x14(%ebx)
80100f98:	83 ec 0c             	sub    $0xc,%esp
80100f9b:	ff 73 10             	pushl  0x10(%ebx)
80100f9e:	e8 ad 07 00 00       	call   80101750 <iunlock>
80100fa3:	83 c4 10             	add    $0x10,%esp
80100fa6:	89 f0                	mov    %esi,%eax
80100fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fab:	5b                   	pop    %ebx
80100fac:	5e                   	pop    %esi
80100fad:	5f                   	pop    %edi
80100fae:	5d                   	pop    %ebp
80100faf:	c3                   	ret    
80100fb0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fb3:	89 45 08             	mov    %eax,0x8(%ebp)
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	5b                   	pop    %ebx
80100fba:	5e                   	pop    %esi
80100fbb:	5f                   	pop    %edi
80100fbc:	5d                   	pop    %ebp
80100fbd:	e9 ce 24 00 00       	jmp    80103490 <piperead>
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fcd:	eb d9                	jmp    80100fa8 <fileread+0x58>
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 66 71 10 80       	push   $0x80107166
80100fd7:	e8 94 f3 ff ff       	call   80100370 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filewrite>:
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 1c             	sub    $0x1c,%esp
80100fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fec:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fef:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
80100ff3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff6:	8b 45 10             	mov    0x10(%ebp),%eax
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100ffc:	0f 84 aa 00 00 00    	je     801010ac <filewrite+0xcc>
80101002:	8b 06                	mov    (%esi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d8 00 00 00    	jne    801010ee <filewrite+0x10e>
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 ff                	xor    %edi,%edi
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 34                	jg     80101053 <filewrite+0x73>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101028:	01 46 14             	add    %eax,0x14(%esi)
8010102b:	83 ec 0c             	sub    $0xc,%esp
8010102e:	ff 76 10             	pushl  0x10(%esi)
80101031:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101034:	e8 17 07 00 00       	call   80101750 <iunlock>
80101039:	e8 82 1b 00 00       	call   80102bc0 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101041:	83 c4 10             	add    $0x10,%esp
80101044:	39 d8                	cmp    %ebx,%eax
80101046:	0f 85 95 00 00 00    	jne    801010e1 <filewrite+0x101>
8010104c:	01 c7                	add    %eax,%edi
8010104e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101051:	7e 6d                	jle    801010c0 <filewrite+0xe0>
80101053:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101056:	b8 00 06 00 00       	mov    $0x600,%eax
8010105b:	29 fb                	sub    %edi,%ebx
8010105d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101063:	0f 4f d8             	cmovg  %eax,%ebx
80101066:	e8 e5 1a 00 00       	call   80102b50 <begin_op>
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
80101071:	e8 fa 05 00 00       	call   80101670 <ilock>
80101076:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101079:	53                   	push   %ebx
8010107a:	ff 76 14             	pushl  0x14(%esi)
8010107d:	01 f8                	add    %edi,%eax
8010107f:	50                   	push   %eax
80101080:	ff 76 10             	pushl  0x10(%esi)
80101083:	e8 c8 09 00 00       	call   80101a50 <writei>
80101088:	83 c4 20             	add    $0x20,%esp
8010108b:	85 c0                	test   %eax,%eax
8010108d:	7f 99                	jg     80101028 <filewrite+0x48>
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	ff 76 10             	pushl  0x10(%esi)
80101095:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101098:	e8 b3 06 00 00       	call   80101750 <iunlock>
8010109d:	e8 1e 1b 00 00       	call   80102bc0 <end_op>
801010a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a5:	83 c4 10             	add    $0x10,%esp
801010a8:	85 c0                	test   %eax,%eax
801010aa:	74 98                	je     80101044 <filewrite+0x64>
801010ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010b4:	5b                   	pop    %ebx
801010b5:	5e                   	pop    %esi
801010b6:	5f                   	pop    %edi
801010b7:	5d                   	pop    %ebp
801010b8:	c3                   	ret    
801010b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010c0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010c3:	75 e7                	jne    801010ac <filewrite+0xcc>
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	89 f8                	mov    %edi,%eax
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
801010cf:	8b 46 0c             	mov    0xc(%esi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
801010dc:	e9 af 22 00 00       	jmp    80103390 <pipewrite>
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 6f 71 10 80       	push   $0x8010716f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 75 71 10 80       	push   $0x80107175
801010f6:	e8 75 f2 ff ff       	call   80100370 <panic>
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <balloc>:
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
80101109:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
8010110f:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101112:	85 c9                	test   %ecx,%ecx
80101114:	0f 84 85 00 00 00    	je     8010119f <balloc+0x9f>
8010111a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
80101121:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101124:	83 ec 08             	sub    $0x8,%esp
80101127:	89 f0                	mov    %esi,%eax
80101129:	c1 f8 0c             	sar    $0xc,%eax
8010112c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101132:	50                   	push   %eax
80101133:	ff 75 d8             	pushl  -0x28(%ebp)
80101136:	e8 95 ef ff ff       	call   801000d0 <bread>
8010113b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101149:	31 c0                	xor    %eax,%eax
8010114b:	eb 2d                	jmp    8010117a <balloc+0x7a>
8010114d:	8d 76 00             	lea    0x0(%esi),%esi
80101150:	89 c1                	mov    %eax,%ecx
80101152:	ba 01 00 00 00       	mov    $0x1,%edx
80101157:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010115a:	83 e1 07             	and    $0x7,%ecx
8010115d:	d3 e2                	shl    %cl,%edx
8010115f:	89 c1                	mov    %eax,%ecx
80101161:	c1 f9 03             	sar    $0x3,%ecx
80101164:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101169:	85 d7                	test   %edx,%edi
8010116b:	74 43                	je     801011b0 <balloc+0xb0>
8010116d:	83 c0 01             	add    $0x1,%eax
80101170:	83 c6 01             	add    $0x1,%esi
80101173:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101178:	74 05                	je     8010117f <balloc+0x7f>
8010117a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010117d:	72 d1                	jb     80101150 <balloc+0x50>
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	ff 75 e4             	pushl  -0x1c(%ebp)
80101185:	e8 56 f0 ff ff       	call   801001e0 <brelse>
8010118a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101191:	83 c4 10             	add    $0x10,%esp
80101194:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101197:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010119d:	77 82                	ja     80101121 <balloc+0x21>
8010119f:	83 ec 0c             	sub    $0xc,%esp
801011a2:	68 7f 71 10 80       	push   $0x8010717f
801011a7:	e8 c4 f1 ff ff       	call   80100370 <panic>
801011ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801011b0:	09 fa                	or     %edi,%edx
801011b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801011b5:	83 ec 0c             	sub    $0xc,%esp
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
801011bc:	57                   	push   %edi
801011bd:	e8 6e 1b 00 00       	call   80102d30 <log_write>
801011c2:	89 3c 24             	mov    %edi,(%esp)
801011c5:	e8 16 f0 ff ff       	call   801001e0 <brelse>
801011ca:	58                   	pop    %eax
801011cb:	5a                   	pop    %edx
801011cc:	56                   	push   %esi
801011cd:	ff 75 d8             	pushl  -0x28(%ebp)
801011d0:	e8 fb ee ff ff       	call   801000d0 <bread>
801011d5:	89 c3                	mov    %eax,%ebx
801011d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011da:	83 c4 0c             	add    $0xc,%esp
801011dd:	68 00 02 00 00       	push   $0x200
801011e2:	6a 00                	push   $0x0
801011e4:	50                   	push   %eax
801011e5:	e8 c6 33 00 00       	call   801045b0 <memset>
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 3e 1b 00 00       	call   80102d30 <log_write>
801011f2:	89 1c 24             	mov    %ebx,(%esp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
801011fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fd:	89 f0                	mov    %esi,%eax
801011ff:	5b                   	pop    %ebx
80101200:	5e                   	pop    %esi
80101201:	5f                   	pop    %edi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret    
80101204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010120a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101210 <iget>:
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	89 c7                	mov    %eax,%edi
80101218:	31 f6                	xor    %esi,%esi
8010121a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
8010121f:	83 ec 28             	sub    $0x28,%esp
80101222:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101225:	68 e0 09 11 80       	push   $0x801109e0
8010122a:	e8 11 32 00 00       	call   80104440 <acquire>
8010122f:	83 c4 10             	add    $0x10,%esp
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101235:	eb 1b                	jmp    80101252 <iget+0x42>
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101240:	85 f6                	test   %esi,%esi
80101242:	74 44                	je     80101288 <iget+0x78>
80101244:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010124a:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101250:	74 4e                	je     801012a0 <iget+0x90>
80101252:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101255:	85 c9                	test   %ecx,%ecx
80101257:	7e e7                	jle    80101240 <iget+0x30>
80101259:	39 3b                	cmp    %edi,(%ebx)
8010125b:	75 e3                	jne    80101240 <iget+0x30>
8010125d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101260:	75 de                	jne    80101240 <iget+0x30>
80101262:	83 ec 0c             	sub    $0xc,%esp
80101265:	83 c1 01             	add    $0x1,%ecx
80101268:	89 de                	mov    %ebx,%esi
8010126a:	68 e0 09 11 80       	push   $0x801109e0
8010126f:	89 4b 08             	mov    %ecx,0x8(%ebx)
80101272:	e8 e9 32 00 00       	call   80104560 <release>
80101277:	83 c4 10             	add    $0x10,%esp
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101288:	85 c9                	test   %ecx,%ecx
8010128a:	0f 44 f3             	cmove  %ebx,%esi
8010128d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101293:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101299:	75 b7                	jne    80101252 <iget+0x42>
8010129b:	90                   	nop
8010129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 2d                	je     801012d1 <iget+0xc1>
801012a4:	83 ec 0c             	sub    $0xc,%esp
801012a7:	89 3e                	mov    %edi,(%esi)
801012a9:	89 56 04             	mov    %edx,0x4(%esi)
801012ac:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
801012b3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801012ba:	68 e0 09 11 80       	push   $0x801109e0
801012bf:	e8 9c 32 00 00       	call   80104560 <release>
801012c4:	83 c4 10             	add    $0x10,%esp
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 95 71 10 80       	push   $0x80107195
801012d9:	e8 92 f0 ff ff       	call   80100370 <panic>
801012de:	66 90                	xchg   %ax,%ax

801012e0 <bmap>:
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c6                	mov    %eax,%esi
801012e8:	83 ec 1c             	sub    $0x1c,%esp
801012eb:	83 fa 0b             	cmp    $0xb,%edx
801012ee:	77 18                	ja     80101308 <bmap+0x28>
801012f0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801012f3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801012f6:	85 c0                	test   %eax,%eax
801012f8:	74 76                	je     80101370 <bmap+0x90>
801012fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012fd:	5b                   	pop    %ebx
801012fe:	5e                   	pop    %esi
801012ff:	5f                   	pop    %edi
80101300:	5d                   	pop    %ebp
80101301:	c3                   	ret    
80101302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101308:	8d 5a f4             	lea    -0xc(%edx),%ebx
8010130b:	83 fb 7f             	cmp    $0x7f,%ebx
8010130e:	0f 87 83 00 00 00    	ja     80101397 <bmap+0xb7>
80101314:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010131a:	85 c0                	test   %eax,%eax
8010131c:	74 6a                	je     80101388 <bmap+0xa8>
8010131e:	83 ec 08             	sub    $0x8,%esp
80101321:	50                   	push   %eax
80101322:	ff 36                	pushl  (%esi)
80101324:	e8 a7 ed ff ff       	call   801000d0 <bread>
80101329:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010132d:	83 c4 10             	add    $0x10,%esp
80101330:	89 c7                	mov    %eax,%edi
80101332:	8b 1a                	mov    (%edx),%ebx
80101334:	85 db                	test   %ebx,%ebx
80101336:	75 1d                	jne    80101355 <bmap+0x75>
80101338:	8b 06                	mov    (%esi),%eax
8010133a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010133d:	e8 be fd ff ff       	call   80101100 <balloc>
80101342:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101345:	83 ec 0c             	sub    $0xc,%esp
80101348:	89 c3                	mov    %eax,%ebx
8010134a:	89 02                	mov    %eax,(%edx)
8010134c:	57                   	push   %edi
8010134d:	e8 de 19 00 00       	call   80102d30 <log_write>
80101352:	83 c4 10             	add    $0x10,%esp
80101355:	83 ec 0c             	sub    $0xc,%esp
80101358:	57                   	push   %edi
80101359:	e8 82 ee ff ff       	call   801001e0 <brelse>
8010135e:	83 c4 10             	add    $0x10,%esp
80101361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101364:	89 d8                	mov    %ebx,%eax
80101366:	5b                   	pop    %ebx
80101367:	5e                   	pop    %esi
80101368:	5f                   	pop    %edi
80101369:	5d                   	pop    %ebp
8010136a:	c3                   	ret    
8010136b:	90                   	nop
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101370:	8b 06                	mov    (%esi),%eax
80101372:	e8 89 fd ff ff       	call   80101100 <balloc>
80101377:	89 43 5c             	mov    %eax,0x5c(%ebx)
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	5b                   	pop    %ebx
8010137e:	5e                   	pop    %esi
8010137f:	5f                   	pop    %edi
80101380:	5d                   	pop    %ebp
80101381:	c3                   	ret    
80101382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101388:	8b 06                	mov    (%esi),%eax
8010138a:	e8 71 fd ff ff       	call   80101100 <balloc>
8010138f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101395:	eb 87                	jmp    8010131e <bmap+0x3e>
80101397:	83 ec 0c             	sub    $0xc,%esp
8010139a:	68 a5 71 10 80       	push   $0x801071a5
8010139f:	e8 cc ef ff ff       	call   80100370 <panic>
801013a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013b0 <readsb>:
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	56                   	push   %esi
801013b4:	53                   	push   %ebx
801013b5:	8b 75 0c             	mov    0xc(%ebp),%esi
801013b8:	83 ec 08             	sub    $0x8,%esp
801013bb:	6a 01                	push   $0x1
801013bd:	ff 75 08             	pushl  0x8(%ebp)
801013c0:	e8 0b ed ff ff       	call   801000d0 <bread>
801013c5:	89 c3                	mov    %eax,%ebx
801013c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ca:	83 c4 0c             	add    $0xc,%esp
801013cd:	6a 1c                	push   $0x1c
801013cf:	50                   	push   %eax
801013d0:	56                   	push   %esi
801013d1:	e8 8a 32 00 00       	call   80104660 <memmove>
801013d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013d9:	83 c4 10             	add    $0x10,%esp
801013dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013df:	5b                   	pop    %ebx
801013e0:	5e                   	pop    %esi
801013e1:	5d                   	pop    %ebp
801013e2:	e9 f9 ed ff ff       	jmp    801001e0 <brelse>
801013e7:	89 f6                	mov    %esi,%esi
801013e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013f0 <bfree>:
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	56                   	push   %esi
801013f4:	53                   	push   %ebx
801013f5:	89 d3                	mov    %edx,%ebx
801013f7:	89 c6                	mov    %eax,%esi
801013f9:	83 ec 08             	sub    $0x8,%esp
801013fc:	68 c0 09 11 80       	push   $0x801109c0
80101401:	50                   	push   %eax
80101402:	e8 a9 ff ff ff       	call   801013b0 <readsb>
80101407:	58                   	pop    %eax
80101408:	5a                   	pop    %edx
80101409:	89 da                	mov    %ebx,%edx
8010140b:	c1 ea 0c             	shr    $0xc,%edx
8010140e:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101414:	52                   	push   %edx
80101415:	56                   	push   %esi
80101416:	e8 b5 ec ff ff       	call   801000d0 <bread>
8010141b:	89 d9                	mov    %ebx,%ecx
8010141d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80101423:	ba 01 00 00 00       	mov    $0x1,%edx
80101428:	83 e1 07             	and    $0x7,%ecx
8010142b:	c1 fb 03             	sar    $0x3,%ebx
8010142e:	83 c4 10             	add    $0x10,%esp
80101431:	d3 e2                	shl    %cl,%edx
80101433:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101438:	85 d1                	test   %edx,%ecx
8010143a:	74 27                	je     80101463 <bfree+0x73>
8010143c:	89 c6                	mov    %eax,%esi
8010143e:	f7 d2                	not    %edx
80101440:	89 c8                	mov    %ecx,%eax
80101442:	83 ec 0c             	sub    $0xc,%esp
80101445:	21 d0                	and    %edx,%eax
80101447:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
8010144b:	56                   	push   %esi
8010144c:	e8 df 18 00 00       	call   80102d30 <log_write>
80101451:	89 34 24             	mov    %esi,(%esp)
80101454:	e8 87 ed ff ff       	call   801001e0 <brelse>
80101459:	83 c4 10             	add    $0x10,%esp
8010145c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010145f:	5b                   	pop    %ebx
80101460:	5e                   	pop    %esi
80101461:	5d                   	pop    %ebp
80101462:	c3                   	ret    
80101463:	83 ec 0c             	sub    $0xc,%esp
80101466:	68 b8 71 10 80       	push   $0x801071b8
8010146b:	e8 00 ef ff ff       	call   80100370 <panic>

80101470 <iinit>:
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101479:	83 ec 0c             	sub    $0xc,%esp
8010147c:	68 cb 71 10 80       	push   $0x801071cb
80101481:	68 e0 09 11 80       	push   $0x801109e0
80101486:	e8 b5 2e 00 00       	call   80104340 <initlock>
8010148b:	83 c4 10             	add    $0x10,%esp
8010148e:	66 90                	xchg   %ax,%ax
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	68 d2 71 10 80       	push   $0x801071d2
80101498:	53                   	push   %ebx
80101499:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010149f:	e8 8c 2d 00 00       	call   80104230 <initsleeplock>
801014a4:	83 c4 10             	add    $0x10,%esp
801014a7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014ad:	75 e1                	jne    80101490 <iinit+0x20>
801014af:	83 ec 08             	sub    $0x8,%esp
801014b2:	68 c0 09 11 80       	push   $0x801109c0
801014b7:	ff 75 08             	pushl  0x8(%ebp)
801014ba:	e8 f1 fe ff ff       	call   801013b0 <readsb>
801014bf:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014c5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014cb:	ff 35 d0 09 11 80    	pushl  0x801109d0
801014d1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801014d7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801014dd:	ff 35 c4 09 11 80    	pushl  0x801109c4
801014e3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801014e9:	68 38 72 10 80       	push   $0x80107238
801014ee:	e8 6d f1 ff ff       	call   80100660 <cprintf>
801014f3:	83 c4 30             	add    $0x30,%esp
801014f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014f9:	c9                   	leave  
801014fa:	c3                   	ret    
801014fb:	90                   	nop
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101500 <ialloc>:
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	57                   	push   %edi
80101504:	56                   	push   %esi
80101505:	53                   	push   %ebx
80101506:	83 ec 1c             	sub    $0x1c,%esp
80101509:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
80101510:	8b 45 0c             	mov    0xc(%ebp),%eax
80101513:	8b 75 08             	mov    0x8(%ebp),%esi
80101516:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101519:	0f 86 91 00 00 00    	jbe    801015b0 <ialloc+0xb0>
8010151f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101524:	eb 21                	jmp    80101547 <ialloc+0x47>
80101526:	8d 76 00             	lea    0x0(%esi),%esi
80101529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101530:	83 ec 0c             	sub    $0xc,%esp
80101533:	83 c3 01             	add    $0x1,%ebx
80101536:	57                   	push   %edi
80101537:	e8 a4 ec ff ff       	call   801001e0 <brelse>
8010153c:	83 c4 10             	add    $0x10,%esp
8010153f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101545:	76 69                	jbe    801015b0 <ialloc+0xb0>
80101547:	89 d8                	mov    %ebx,%eax
80101549:	83 ec 08             	sub    $0x8,%esp
8010154c:	c1 e8 03             	shr    $0x3,%eax
8010154f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101555:	50                   	push   %eax
80101556:	56                   	push   %esi
80101557:	e8 74 eb ff ff       	call   801000d0 <bread>
8010155c:	89 c7                	mov    %eax,%edi
8010155e:	89 d8                	mov    %ebx,%eax
80101560:	83 c4 10             	add    $0x10,%esp
80101563:	83 e0 07             	and    $0x7,%eax
80101566:	c1 e0 06             	shl    $0x6,%eax
80101569:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
8010156d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101571:	75 bd                	jne    80101530 <ialloc+0x30>
80101573:	83 ec 04             	sub    $0x4,%esp
80101576:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101579:	6a 40                	push   $0x40
8010157b:	6a 00                	push   $0x0
8010157d:	51                   	push   %ecx
8010157e:	e8 2d 30 00 00       	call   801045b0 <memset>
80101583:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101587:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010158a:	66 89 01             	mov    %ax,(%ecx)
8010158d:	89 3c 24             	mov    %edi,(%esp)
80101590:	e8 9b 17 00 00       	call   80102d30 <log_write>
80101595:	89 3c 24             	mov    %edi,(%esp)
80101598:	e8 43 ec ff ff       	call   801001e0 <brelse>
8010159d:	83 c4 10             	add    $0x10,%esp
801015a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015a3:	89 da                	mov    %ebx,%edx
801015a5:	89 f0                	mov    %esi,%eax
801015a7:	5b                   	pop    %ebx
801015a8:	5e                   	pop    %esi
801015a9:	5f                   	pop    %edi
801015aa:	5d                   	pop    %ebp
801015ab:	e9 60 fc ff ff       	jmp    80101210 <iget>
801015b0:	83 ec 0c             	sub    $0xc,%esp
801015b3:	68 d8 71 10 80       	push   $0x801071d8
801015b8:	e8 b3 ed ff ff       	call   80100370 <panic>
801015bd:	8d 76 00             	lea    0x0(%esi),%esi

801015c0 <iupdate>:
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	56                   	push   %esi
801015c4:	53                   	push   %ebx
801015c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801015c8:	83 ec 08             	sub    $0x8,%esp
801015cb:	8b 43 04             	mov    0x4(%ebx),%eax
801015ce:	83 c3 5c             	add    $0x5c,%ebx
801015d1:	c1 e8 03             	shr    $0x3,%eax
801015d4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015da:	50                   	push   %eax
801015db:	ff 73 a4             	pushl  -0x5c(%ebx)
801015de:	e8 ed ea ff ff       	call   801000d0 <bread>
801015e3:	89 c6                	mov    %eax,%esi
801015e5:	8b 43 a8             	mov    -0x58(%ebx),%eax
801015e8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
801015ec:	83 c4 0c             	add    $0xc,%esp
801015ef:	83 e0 07             	and    $0x7,%eax
801015f2:	c1 e0 06             	shl    $0x6,%eax
801015f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
801015f9:	66 89 10             	mov    %dx,(%eax)
801015fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80101600:	83 c0 0c             	add    $0xc,%eax
80101603:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80101607:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010160b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
8010160f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101613:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80101617:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010161a:	89 50 fc             	mov    %edx,-0x4(%eax)
8010161d:	6a 34                	push   $0x34
8010161f:	53                   	push   %ebx
80101620:	50                   	push   %eax
80101621:	e8 3a 30 00 00       	call   80104660 <memmove>
80101626:	89 34 24             	mov    %esi,(%esp)
80101629:	e8 02 17 00 00       	call   80102d30 <log_write>
8010162e:	89 75 08             	mov    %esi,0x8(%ebp)
80101631:	83 c4 10             	add    $0x10,%esp
80101634:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101637:	5b                   	pop    %ebx
80101638:	5e                   	pop    %esi
80101639:	5d                   	pop    %ebp
8010163a:	e9 a1 eb ff ff       	jmp    801001e0 <brelse>
8010163f:	90                   	nop

80101640 <idup>:
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	53                   	push   %ebx
80101644:	83 ec 10             	sub    $0x10,%esp
80101647:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010164a:	68 e0 09 11 80       	push   $0x801109e0
8010164f:	e8 ec 2d 00 00       	call   80104440 <acquire>
80101654:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80101658:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010165f:	e8 fc 2e 00 00       	call   80104560 <release>
80101664:	89 d8                	mov    %ebx,%eax
80101666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101669:	c9                   	leave  
8010166a:	c3                   	ret    
8010166b:	90                   	nop
8010166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101670 <ilock>:
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101678:	85 db                	test   %ebx,%ebx
8010167a:	0f 84 b7 00 00 00    	je     80101737 <ilock+0xc7>
80101680:	8b 53 08             	mov    0x8(%ebx),%edx
80101683:	85 d2                	test   %edx,%edx
80101685:	0f 8e ac 00 00 00    	jle    80101737 <ilock+0xc7>
8010168b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010168e:	83 ec 0c             	sub    $0xc,%esp
80101691:	50                   	push   %eax
80101692:	e8 d9 2b 00 00       	call   80104270 <acquiresleep>
80101697:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010169a:	83 c4 10             	add    $0x10,%esp
8010169d:	85 c0                	test   %eax,%eax
8010169f:	74 0f                	je     801016b0 <ilock+0x40>
801016a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016a4:	5b                   	pop    %ebx
801016a5:	5e                   	pop    %esi
801016a6:	5d                   	pop    %ebp
801016a7:	c3                   	ret    
801016a8:	90                   	nop
801016a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016b0:	8b 43 04             	mov    0x4(%ebx),%eax
801016b3:	83 ec 08             	sub    $0x8,%esp
801016b6:	c1 e8 03             	shr    $0x3,%eax
801016b9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016bf:	50                   	push   %eax
801016c0:	ff 33                	pushl  (%ebx)
801016c2:	e8 09 ea ff ff       	call   801000d0 <bread>
801016c7:	89 c6                	mov    %eax,%esi
801016c9:	8b 43 04             	mov    0x4(%ebx),%eax
801016cc:	83 c4 0c             	add    $0xc,%esp
801016cf:	83 e0 07             	and    $0x7,%eax
801016d2:	c1 e0 06             	shl    $0x6,%eax
801016d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
801016d9:	0f b7 10             	movzwl (%eax),%edx
801016dc:	83 c0 0c             	add    $0xc,%eax
801016df:	66 89 53 50          	mov    %dx,0x50(%ebx)
801016e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
801016eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
801016f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
801016fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016fe:	89 53 58             	mov    %edx,0x58(%ebx)
80101701:	6a 34                	push   $0x34
80101703:	50                   	push   %eax
80101704:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101707:	50                   	push   %eax
80101708:	e8 53 2f 00 00       	call   80104660 <memmove>
8010170d:	89 34 24             	mov    %esi,(%esp)
80101710:	e8 cb ea ff ff       	call   801001e0 <brelse>
80101715:	83 c4 10             	add    $0x10,%esp
80101718:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010171d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80101724:	0f 85 77 ff ff ff    	jne    801016a1 <ilock+0x31>
8010172a:	83 ec 0c             	sub    $0xc,%esp
8010172d:	68 f0 71 10 80       	push   $0x801071f0
80101732:	e8 39 ec ff ff       	call   80100370 <panic>
80101737:	83 ec 0c             	sub    $0xc,%esp
8010173a:	68 ea 71 10 80       	push   $0x801071ea
8010173f:	e8 2c ec ff ff       	call   80100370 <panic>
80101744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010174a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101750 <iunlock>:
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101758:	85 db                	test   %ebx,%ebx
8010175a:	74 28                	je     80101784 <iunlock+0x34>
8010175c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010175f:	83 ec 0c             	sub    $0xc,%esp
80101762:	56                   	push   %esi
80101763:	e8 a8 2b 00 00       	call   80104310 <holdingsleep>
80101768:	83 c4 10             	add    $0x10,%esp
8010176b:	85 c0                	test   %eax,%eax
8010176d:	74 15                	je     80101784 <iunlock+0x34>
8010176f:	8b 43 08             	mov    0x8(%ebx),%eax
80101772:	85 c0                	test   %eax,%eax
80101774:	7e 0e                	jle    80101784 <iunlock+0x34>
80101776:	89 75 08             	mov    %esi,0x8(%ebp)
80101779:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010177c:	5b                   	pop    %ebx
8010177d:	5e                   	pop    %esi
8010177e:	5d                   	pop    %ebp
8010177f:	e9 4c 2b 00 00       	jmp    801042d0 <releasesleep>
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 ff 71 10 80       	push   $0x801071ff
8010178c:	e8 df eb ff ff       	call   80100370 <panic>
80101791:	eb 0d                	jmp    801017a0 <iput>
80101793:	90                   	nop
80101794:	90                   	nop
80101795:	90                   	nop
80101796:	90                   	nop
80101797:	90                   	nop
80101798:	90                   	nop
80101799:	90                   	nop
8010179a:	90                   	nop
8010179b:	90                   	nop
8010179c:	90                   	nop
8010179d:	90                   	nop
8010179e:	90                   	nop
8010179f:	90                   	nop

801017a0 <iput>:
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	57                   	push   %edi
801017a4:	56                   	push   %esi
801017a5:	53                   	push   %ebx
801017a6:	83 ec 28             	sub    $0x28,%esp
801017a9:	8b 75 08             	mov    0x8(%ebp),%esi
801017ac:	8d 7e 0c             	lea    0xc(%esi),%edi
801017af:	57                   	push   %edi
801017b0:	e8 bb 2a 00 00       	call   80104270 <acquiresleep>
801017b5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	85 d2                	test   %edx,%edx
801017bd:	74 07                	je     801017c6 <iput+0x26>
801017bf:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017c4:	74 32                	je     801017f8 <iput+0x58>
801017c6:	83 ec 0c             	sub    $0xc,%esp
801017c9:	57                   	push   %edi
801017ca:	e8 01 2b 00 00       	call   801042d0 <releasesleep>
801017cf:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017d6:	e8 65 2c 00 00       	call   80104440 <acquire>
801017db:	83 6e 08 01          	subl   $0x1,0x8(%esi)
801017df:	83 c4 10             	add    $0x10,%esp
801017e2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
801017e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017ec:	5b                   	pop    %ebx
801017ed:	5e                   	pop    %esi
801017ee:	5f                   	pop    %edi
801017ef:	5d                   	pop    %ebp
801017f0:	e9 6b 2d 00 00       	jmp    80104560 <release>
801017f5:	8d 76 00             	lea    0x0(%esi),%esi
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	68 e0 09 11 80       	push   $0x801109e0
80101800:	e8 3b 2c 00 00       	call   80104440 <acquire>
80101805:	8b 5e 08             	mov    0x8(%esi),%ebx
80101808:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010180f:	e8 4c 2d 00 00       	call   80104560 <release>
80101814:	83 c4 10             	add    $0x10,%esp
80101817:	83 fb 01             	cmp    $0x1,%ebx
8010181a:	75 aa                	jne    801017c6 <iput+0x26>
8010181c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101822:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101825:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101828:	89 cf                	mov    %ecx,%edi
8010182a:	eb 0b                	jmp    80101837 <iput+0x97>
8010182c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101830:	83 c3 04             	add    $0x4,%ebx
80101833:	39 fb                	cmp    %edi,%ebx
80101835:	74 19                	je     80101850 <iput+0xb0>
80101837:	8b 13                	mov    (%ebx),%edx
80101839:	85 d2                	test   %edx,%edx
8010183b:	74 f3                	je     80101830 <iput+0x90>
8010183d:	8b 06                	mov    (%esi),%eax
8010183f:	e8 ac fb ff ff       	call   801013f0 <bfree>
80101844:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010184a:	eb e4                	jmp    80101830 <iput+0x90>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101856:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101859:	85 c0                	test   %eax,%eax
8010185b:	75 33                	jne    80101890 <iput+0xf0>
8010185d:	83 ec 0c             	sub    $0xc,%esp
80101860:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
80101867:	56                   	push   %esi
80101868:	e8 53 fd ff ff       	call   801015c0 <iupdate>
8010186d:	31 c0                	xor    %eax,%eax
8010186f:	66 89 46 50          	mov    %ax,0x50(%esi)
80101873:	89 34 24             	mov    %esi,(%esp)
80101876:	e8 45 fd ff ff       	call   801015c0 <iupdate>
8010187b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101882:	83 c4 10             	add    $0x10,%esp
80101885:	e9 3c ff ff ff       	jmp    801017c6 <iput+0x26>
8010188a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101890:	83 ec 08             	sub    $0x8,%esp
80101893:	50                   	push   %eax
80101894:	ff 36                	pushl  (%esi)
80101896:	e8 35 e8 ff ff       	call   801000d0 <bread>
8010189b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018a1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801018a7:	8d 58 5c             	lea    0x5c(%eax),%ebx
801018aa:	83 c4 10             	add    $0x10,%esp
801018ad:	89 cf                	mov    %ecx,%edi
801018af:	eb 0e                	jmp    801018bf <iput+0x11f>
801018b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018b8:	83 c3 04             	add    $0x4,%ebx
801018bb:	39 fb                	cmp    %edi,%ebx
801018bd:	74 0f                	je     801018ce <iput+0x12e>
801018bf:	8b 13                	mov    (%ebx),%edx
801018c1:	85 d2                	test   %edx,%edx
801018c3:	74 f3                	je     801018b8 <iput+0x118>
801018c5:	8b 06                	mov    (%esi),%eax
801018c7:	e8 24 fb ff ff       	call   801013f0 <bfree>
801018cc:	eb ea                	jmp    801018b8 <iput+0x118>
801018ce:	83 ec 0c             	sub    $0xc,%esp
801018d1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018d7:	e8 04 e9 ff ff       	call   801001e0 <brelse>
801018dc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018e2:	8b 06                	mov    (%esi),%eax
801018e4:	e8 07 fb ff ff       	call   801013f0 <bfree>
801018e9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018f0:	00 00 00 
801018f3:	83 c4 10             	add    $0x10,%esp
801018f6:	e9 62 ff ff ff       	jmp    8010185d <iput+0xbd>
801018fb:	90                   	nop
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101900 <iunlockput>:
80101900:	55                   	push   %ebp
80101901:	89 e5                	mov    %esp,%ebp
80101903:	53                   	push   %ebx
80101904:	83 ec 10             	sub    $0x10,%esp
80101907:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010190a:	53                   	push   %ebx
8010190b:	e8 40 fe ff ff       	call   80101750 <iunlock>
80101910:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101919:	c9                   	leave  
8010191a:	e9 81 fe ff ff       	jmp    801017a0 <iput>
8010191f:	90                   	nop

80101920 <stati>:
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	8b 55 08             	mov    0x8(%ebp),%edx
80101926:	8b 45 0c             	mov    0xc(%ebp),%eax
80101929:	8b 0a                	mov    (%edx),%ecx
8010192b:	89 48 04             	mov    %ecx,0x4(%eax)
8010192e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101931:	89 48 08             	mov    %ecx,0x8(%eax)
80101934:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101938:	66 89 08             	mov    %cx,(%eax)
8010193b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010193f:	66 89 48 0c          	mov    %cx,0xc(%eax)
80101943:	8b 52 58             	mov    0x58(%edx),%edx
80101946:	89 50 10             	mov    %edx,0x10(%eax)
80101949:	5d                   	pop    %ebp
8010194a:	c3                   	ret    
8010194b:	90                   	nop
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <readi>:
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	57                   	push   %edi
80101954:	56                   	push   %esi
80101955:	53                   	push   %ebx
80101956:	83 ec 1c             	sub    $0x1c,%esp
80101959:	8b 45 08             	mov    0x8(%ebp),%eax
8010195c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010195f:	8b 75 10             	mov    0x10(%ebp),%esi
80101962:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101967:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010196a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010196d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101970:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101973:	0f 84 a7 00 00 00    	je     80101a20 <readi+0xd0>
80101979:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010197c:	8b 40 58             	mov    0x58(%eax),%eax
8010197f:	39 f0                	cmp    %esi,%eax
80101981:	0f 82 c1 00 00 00    	jb     80101a48 <readi+0xf8>
80101987:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010198a:	89 fa                	mov    %edi,%edx
8010198c:	01 f2                	add    %esi,%edx
8010198e:	0f 82 b4 00 00 00    	jb     80101a48 <readi+0xf8>
80101994:	89 c1                	mov    %eax,%ecx
80101996:	29 f1                	sub    %esi,%ecx
80101998:	39 d0                	cmp    %edx,%eax
8010199a:	0f 43 cf             	cmovae %edi,%ecx
8010199d:	31 ff                	xor    %edi,%edi
8010199f:	85 c9                	test   %ecx,%ecx
801019a1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801019a4:	74 6d                	je     80101a13 <readi+0xc3>
801019a6:	8d 76 00             	lea    0x0(%esi),%esi
801019a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801019b0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019b3:	89 f2                	mov    %esi,%edx
801019b5:	c1 ea 09             	shr    $0x9,%edx
801019b8:	89 d8                	mov    %ebx,%eax
801019ba:	e8 21 f9 ff ff       	call   801012e0 <bmap>
801019bf:	83 ec 08             	sub    $0x8,%esp
801019c2:	50                   	push   %eax
801019c3:	ff 33                	pushl  (%ebx)
801019c5:	bb 00 02 00 00       	mov    $0x200,%ebx
801019ca:	e8 01 e7 ff ff       	call   801000d0 <bread>
801019cf:	89 c2                	mov    %eax,%edx
801019d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019d4:	89 f1                	mov    %esi,%ecx
801019d6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019dc:	83 c4 0c             	add    $0xc,%esp
801019df:	89 55 dc             	mov    %edx,-0x24(%ebp)
801019e2:	29 cb                	sub    %ecx,%ebx
801019e4:	29 f8                	sub    %edi,%eax
801019e6:	39 c3                	cmp    %eax,%ebx
801019e8:	0f 47 d8             	cmova  %eax,%ebx
801019eb:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019ef:	53                   	push   %ebx
801019f0:	01 df                	add    %ebx,%edi
801019f2:	01 de                	add    %ebx,%esi
801019f4:	50                   	push   %eax
801019f5:	ff 75 e0             	pushl  -0x20(%ebp)
801019f8:	e8 63 2c 00 00       	call   80104660 <memmove>
801019fd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a00:	89 14 24             	mov    %edx,(%esp)
80101a03:	e8 d8 e7 ff ff       	call   801001e0 <brelse>
80101a08:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a0b:	83 c4 10             	add    $0x10,%esp
80101a0e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a11:	77 9d                	ja     801019b0 <readi+0x60>
80101a13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a19:	5b                   	pop    %ebx
80101a1a:	5e                   	pop    %esi
80101a1b:	5f                   	pop    %edi
80101a1c:	5d                   	pop    %ebp
80101a1d:	c3                   	ret    
80101a1e:	66 90                	xchg   %ax,%ax
80101a20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a24:	66 83 f8 09          	cmp    $0x9,%ax
80101a28:	77 1e                	ja     80101a48 <readi+0xf8>
80101a2a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a31:	85 c0                	test   %eax,%eax
80101a33:	74 13                	je     80101a48 <readi+0xf8>
80101a35:	89 7d 10             	mov    %edi,0x10(%ebp)
80101a38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a3b:	5b                   	pop    %ebx
80101a3c:	5e                   	pop    %esi
80101a3d:	5f                   	pop    %edi
80101a3e:	5d                   	pop    %ebp
80101a3f:	ff e0                	jmp    *%eax
80101a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a4d:	eb c7                	jmp    80101a16 <readi+0xc6>
80101a4f:	90                   	nop

80101a50 <writei>:
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	57                   	push   %edi
80101a54:	56                   	push   %esi
80101a55:	53                   	push   %ebx
80101a56:	83 ec 1c             	sub    $0x1c,%esp
80101a59:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a5f:	8b 7d 14             	mov    0x14(%ebp),%edi
80101a62:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101a67:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a6a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a6d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a70:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a73:	0f 84 b7 00 00 00    	je     80101b30 <writei+0xe0>
80101a79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a7c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a7f:	0f 82 eb 00 00 00    	jb     80101b70 <writei+0x120>
80101a85:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a88:	89 f8                	mov    %edi,%eax
80101a8a:	01 f0                	add    %esi,%eax
80101a8c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a91:	0f 87 d9 00 00 00    	ja     80101b70 <writei+0x120>
80101a97:	39 c6                	cmp    %eax,%esi
80101a99:	0f 87 d1 00 00 00    	ja     80101b70 <writei+0x120>
80101a9f:	85 ff                	test   %edi,%edi
80101aa1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101aa8:	74 78                	je     80101b22 <writei+0xd2>
80101aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ab0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ab3:	89 f2                	mov    %esi,%edx
80101ab5:	bb 00 02 00 00       	mov    $0x200,%ebx
80101aba:	c1 ea 09             	shr    $0x9,%edx
80101abd:	89 f8                	mov    %edi,%eax
80101abf:	e8 1c f8 ff ff       	call   801012e0 <bmap>
80101ac4:	83 ec 08             	sub    $0x8,%esp
80101ac7:	50                   	push   %eax
80101ac8:	ff 37                	pushl  (%edi)
80101aca:	e8 01 e6 ff ff       	call   801000d0 <bread>
80101acf:	89 c7                	mov    %eax,%edi
80101ad1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ad4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101ad7:	89 f1                	mov    %esi,%ecx
80101ad9:	83 c4 0c             	add    $0xc,%esp
80101adc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ae2:	29 cb                	sub    %ecx,%ebx
80101ae4:	39 c3                	cmp    %eax,%ebx
80101ae6:	0f 47 d8             	cmova  %eax,%ebx
80101ae9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101aed:	53                   	push   %ebx
80101aee:	ff 75 dc             	pushl  -0x24(%ebp)
80101af1:	01 de                	add    %ebx,%esi
80101af3:	50                   	push   %eax
80101af4:	e8 67 2b 00 00       	call   80104660 <memmove>
80101af9:	89 3c 24             	mov    %edi,(%esp)
80101afc:	e8 2f 12 00 00       	call   80102d30 <log_write>
80101b01:	89 3c 24             	mov    %edi,(%esp)
80101b04:	e8 d7 e6 ff ff       	call   801001e0 <brelse>
80101b09:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b0c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b0f:	83 c4 10             	add    $0x10,%esp
80101b12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b15:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b18:	77 96                	ja     80101ab0 <writei+0x60>
80101b1a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b1d:	3b 70 58             	cmp    0x58(%eax),%esi
80101b20:	77 36                	ja     80101b58 <writei+0x108>
80101b22:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b28:	5b                   	pop    %ebx
80101b29:	5e                   	pop    %esi
80101b2a:	5f                   	pop    %edi
80101b2b:	5d                   	pop    %ebp
80101b2c:	c3                   	ret    
80101b2d:	8d 76 00             	lea    0x0(%esi),%esi
80101b30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b34:	66 83 f8 09          	cmp    $0x9,%ax
80101b38:	77 36                	ja     80101b70 <writei+0x120>
80101b3a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b41:	85 c0                	test   %eax,%eax
80101b43:	74 2b                	je     80101b70 <writei+0x120>
80101b45:	89 7d 10             	mov    %edi,0x10(%ebp)
80101b48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b4b:	5b                   	pop    %ebx
80101b4c:	5e                   	pop    %esi
80101b4d:	5f                   	pop    %edi
80101b4e:	5d                   	pop    %ebp
80101b4f:	ff e0                	jmp    *%eax
80101b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b58:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5b:	83 ec 0c             	sub    $0xc,%esp
80101b5e:	89 70 58             	mov    %esi,0x58(%eax)
80101b61:	50                   	push   %eax
80101b62:	e8 59 fa ff ff       	call   801015c0 <iupdate>
80101b67:	83 c4 10             	add    $0x10,%esp
80101b6a:	eb b6                	jmp    80101b22 <writei+0xd2>
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b75:	eb ae                	jmp    80101b25 <writei+0xd5>
80101b77:	89 f6                	mov    %esi,%esi
80101b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b80 <namecmp>:
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	83 ec 0c             	sub    $0xc,%esp
80101b86:	6a 0e                	push   $0xe
80101b88:	ff 75 0c             	pushl  0xc(%ebp)
80101b8b:	ff 75 08             	pushl  0x8(%ebp)
80101b8e:	e8 4d 2b 00 00       	call   801046e0 <strncmp>
80101b93:	c9                   	leave  
80101b94:	c3                   	ret    
80101b95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <dirlookup>:
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 1c             	sub    $0x1c,%esp
80101ba9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bb1:	0f 85 80 00 00 00    	jne    80101c37 <dirlookup+0x97>
80101bb7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bba:	31 ff                	xor    %edi,%edi
80101bbc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bbf:	85 d2                	test   %edx,%edx
80101bc1:	75 0d                	jne    80101bd0 <dirlookup+0x30>
80101bc3:	eb 5b                	jmp    80101c20 <dirlookup+0x80>
80101bc5:	8d 76 00             	lea    0x0(%esi),%esi
80101bc8:	83 c7 10             	add    $0x10,%edi
80101bcb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bce:	76 50                	jbe    80101c20 <dirlookup+0x80>
80101bd0:	6a 10                	push   $0x10
80101bd2:	57                   	push   %edi
80101bd3:	56                   	push   %esi
80101bd4:	53                   	push   %ebx
80101bd5:	e8 76 fd ff ff       	call   80101950 <readi>
80101bda:	83 c4 10             	add    $0x10,%esp
80101bdd:	83 f8 10             	cmp    $0x10,%eax
80101be0:	75 48                	jne    80101c2a <dirlookup+0x8a>
80101be2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101be7:	74 df                	je     80101bc8 <dirlookup+0x28>
80101be9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bec:	83 ec 04             	sub    $0x4,%esp
80101bef:	6a 0e                	push   $0xe
80101bf1:	50                   	push   %eax
80101bf2:	ff 75 0c             	pushl  0xc(%ebp)
80101bf5:	e8 e6 2a 00 00       	call   801046e0 <strncmp>
80101bfa:	83 c4 10             	add    $0x10,%esp
80101bfd:	85 c0                	test   %eax,%eax
80101bff:	75 c7                	jne    80101bc8 <dirlookup+0x28>
80101c01:	8b 45 10             	mov    0x10(%ebp),%eax
80101c04:	85 c0                	test   %eax,%eax
80101c06:	74 05                	je     80101c0d <dirlookup+0x6d>
80101c08:	8b 45 10             	mov    0x10(%ebp),%eax
80101c0b:	89 38                	mov    %edi,(%eax)
80101c0d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c11:	8b 03                	mov    (%ebx),%eax
80101c13:	e8 f8 f5 ff ff       	call   80101210 <iget>
80101c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c1b:	5b                   	pop    %ebx
80101c1c:	5e                   	pop    %esi
80101c1d:	5f                   	pop    %edi
80101c1e:	5d                   	pop    %ebp
80101c1f:	c3                   	ret    
80101c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c23:	31 c0                	xor    %eax,%eax
80101c25:	5b                   	pop    %ebx
80101c26:	5e                   	pop    %esi
80101c27:	5f                   	pop    %edi
80101c28:	5d                   	pop    %ebp
80101c29:	c3                   	ret    
80101c2a:	83 ec 0c             	sub    $0xc,%esp
80101c2d:	68 19 72 10 80       	push   $0x80107219
80101c32:	e8 39 e7 ff ff       	call   80100370 <panic>
80101c37:	83 ec 0c             	sub    $0xc,%esp
80101c3a:	68 07 72 10 80       	push   $0x80107207
80101c3f:	e8 2c e7 ff ff       	call   80100370 <panic>
80101c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c50 <namex>:
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	89 cf                	mov    %ecx,%edi
80101c58:	89 c3                	mov    %eax,%ebx
80101c5a:	83 ec 1c             	sub    $0x1c,%esp
80101c5d:	80 38 2f             	cmpb   $0x2f,(%eax)
80101c60:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101c63:	0f 84 53 01 00 00    	je     80101dbc <namex+0x16c>
80101c69:	e8 22 1b 00 00       	call   80103790 <myproc>
80101c6e:	83 ec 0c             	sub    $0xc,%esp
80101c71:	8b 70 68             	mov    0x68(%eax),%esi
80101c74:	68 e0 09 11 80       	push   $0x801109e0
80101c79:	e8 c2 27 00 00       	call   80104440 <acquire>
80101c7e:	83 46 08 01          	addl   $0x1,0x8(%esi)
80101c82:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101c89:	e8 d2 28 00 00       	call   80104560 <release>
80101c8e:	83 c4 10             	add    $0x10,%esp
80101c91:	eb 08                	jmp    80101c9b <namex+0x4b>
80101c93:	90                   	nop
80101c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c98:	83 c3 01             	add    $0x1,%ebx
80101c9b:	0f b6 03             	movzbl (%ebx),%eax
80101c9e:	3c 2f                	cmp    $0x2f,%al
80101ca0:	74 f6                	je     80101c98 <namex+0x48>
80101ca2:	84 c0                	test   %al,%al
80101ca4:	0f 84 e3 00 00 00    	je     80101d8d <namex+0x13d>
80101caa:	0f b6 03             	movzbl (%ebx),%eax
80101cad:	89 da                	mov    %ebx,%edx
80101caf:	84 c0                	test   %al,%al
80101cb1:	0f 84 ac 00 00 00    	je     80101d63 <namex+0x113>
80101cb7:	3c 2f                	cmp    $0x2f,%al
80101cb9:	75 09                	jne    80101cc4 <namex+0x74>
80101cbb:	e9 a3 00 00 00       	jmp    80101d63 <namex+0x113>
80101cc0:	84 c0                	test   %al,%al
80101cc2:	74 0a                	je     80101cce <namex+0x7e>
80101cc4:	83 c2 01             	add    $0x1,%edx
80101cc7:	0f b6 02             	movzbl (%edx),%eax
80101cca:	3c 2f                	cmp    $0x2f,%al
80101ccc:	75 f2                	jne    80101cc0 <namex+0x70>
80101cce:	89 d1                	mov    %edx,%ecx
80101cd0:	29 d9                	sub    %ebx,%ecx
80101cd2:	83 f9 0d             	cmp    $0xd,%ecx
80101cd5:	0f 8e 8d 00 00 00    	jle    80101d68 <namex+0x118>
80101cdb:	83 ec 04             	sub    $0x4,%esp
80101cde:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ce1:	6a 0e                	push   $0xe
80101ce3:	53                   	push   %ebx
80101ce4:	57                   	push   %edi
80101ce5:	e8 76 29 00 00       	call   80104660 <memmove>
80101cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ced:	83 c4 10             	add    $0x10,%esp
80101cf0:	89 d3                	mov    %edx,%ebx
80101cf2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cf5:	75 11                	jne    80101d08 <namex+0xb8>
80101cf7:	89 f6                	mov    %esi,%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101d00:	83 c3 01             	add    $0x1,%ebx
80101d03:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d06:	74 f8                	je     80101d00 <namex+0xb0>
80101d08:	83 ec 0c             	sub    $0xc,%esp
80101d0b:	56                   	push   %esi
80101d0c:	e8 5f f9 ff ff       	call   80101670 <ilock>
80101d11:	83 c4 10             	add    $0x10,%esp
80101d14:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d19:	0f 85 7f 00 00 00    	jne    80101d9e <namex+0x14e>
80101d1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d22:	85 d2                	test   %edx,%edx
80101d24:	74 09                	je     80101d2f <namex+0xdf>
80101d26:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d29:	0f 84 a3 00 00 00    	je     80101dd2 <namex+0x182>
80101d2f:	83 ec 04             	sub    $0x4,%esp
80101d32:	6a 00                	push   $0x0
80101d34:	57                   	push   %edi
80101d35:	56                   	push   %esi
80101d36:	e8 65 fe ff ff       	call   80101ba0 <dirlookup>
80101d3b:	83 c4 10             	add    $0x10,%esp
80101d3e:	85 c0                	test   %eax,%eax
80101d40:	74 5c                	je     80101d9e <namex+0x14e>
80101d42:	83 ec 0c             	sub    $0xc,%esp
80101d45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d48:	56                   	push   %esi
80101d49:	e8 02 fa ff ff       	call   80101750 <iunlock>
80101d4e:	89 34 24             	mov    %esi,(%esp)
80101d51:	e8 4a fa ff ff       	call   801017a0 <iput>
80101d56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d59:	83 c4 10             	add    $0x10,%esp
80101d5c:	89 c6                	mov    %eax,%esi
80101d5e:	e9 38 ff ff ff       	jmp    80101c9b <namex+0x4b>
80101d63:	31 c9                	xor    %ecx,%ecx
80101d65:	8d 76 00             	lea    0x0(%esi),%esi
80101d68:	83 ec 04             	sub    $0x4,%esp
80101d6b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d6e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d71:	51                   	push   %ecx
80101d72:	53                   	push   %ebx
80101d73:	57                   	push   %edi
80101d74:	e8 e7 28 00 00       	call   80104660 <memmove>
80101d79:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d7f:	83 c4 10             	add    $0x10,%esp
80101d82:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d86:	89 d3                	mov    %edx,%ebx
80101d88:	e9 65 ff ff ff       	jmp    80101cf2 <namex+0xa2>
80101d8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d90:	85 c0                	test   %eax,%eax
80101d92:	75 54                	jne    80101de8 <namex+0x198>
80101d94:	89 f0                	mov    %esi,%eax
80101d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d99:	5b                   	pop    %ebx
80101d9a:	5e                   	pop    %esi
80101d9b:	5f                   	pop    %edi
80101d9c:	5d                   	pop    %ebp
80101d9d:	c3                   	ret    
80101d9e:	83 ec 0c             	sub    $0xc,%esp
80101da1:	56                   	push   %esi
80101da2:	e8 a9 f9 ff ff       	call   80101750 <iunlock>
80101da7:	89 34 24             	mov    %esi,(%esp)
80101daa:	e8 f1 f9 ff ff       	call   801017a0 <iput>
80101daf:	83 c4 10             	add    $0x10,%esp
80101db2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db5:	31 c0                	xor    %eax,%eax
80101db7:	5b                   	pop    %ebx
80101db8:	5e                   	pop    %esi
80101db9:	5f                   	pop    %edi
80101dba:	5d                   	pop    %ebp
80101dbb:	c3                   	ret    
80101dbc:	ba 01 00 00 00       	mov    $0x1,%edx
80101dc1:	b8 01 00 00 00       	mov    $0x1,%eax
80101dc6:	e8 45 f4 ff ff       	call   80101210 <iget>
80101dcb:	89 c6                	mov    %eax,%esi
80101dcd:	e9 c9 fe ff ff       	jmp    80101c9b <namex+0x4b>
80101dd2:	83 ec 0c             	sub    $0xc,%esp
80101dd5:	56                   	push   %esi
80101dd6:	e8 75 f9 ff ff       	call   80101750 <iunlock>
80101ddb:	83 c4 10             	add    $0x10,%esp
80101dde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de1:	89 f0                	mov    %esi,%eax
80101de3:	5b                   	pop    %ebx
80101de4:	5e                   	pop    %esi
80101de5:	5f                   	pop    %edi
80101de6:	5d                   	pop    %ebp
80101de7:	c3                   	ret    
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	56                   	push   %esi
80101dec:	e8 af f9 ff ff       	call   801017a0 <iput>
80101df1:	83 c4 10             	add    $0x10,%esp
80101df4:	31 c0                	xor    %eax,%eax
80101df6:	eb 9e                	jmp    80101d96 <namex+0x146>
80101df8:	90                   	nop
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e00 <dirlink>:
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 20             	sub    $0x20,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101e0c:	6a 00                	push   $0x0
80101e0e:	ff 75 0c             	pushl  0xc(%ebp)
80101e11:	53                   	push   %ebx
80101e12:	e8 89 fd ff ff       	call   80101ba0 <dirlookup>
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	85 c0                	test   %eax,%eax
80101e1c:	75 67                	jne    80101e85 <dirlink+0x85>
80101e1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e24:	85 ff                	test   %edi,%edi
80101e26:	74 29                	je     80101e51 <dirlink+0x51>
80101e28:	31 ff                	xor    %edi,%edi
80101e2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e2d:	eb 09                	jmp    80101e38 <dirlink+0x38>
80101e2f:	90                   	nop
80101e30:	83 c7 10             	add    $0x10,%edi
80101e33:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e36:	76 19                	jbe    80101e51 <dirlink+0x51>
80101e38:	6a 10                	push   $0x10
80101e3a:	57                   	push   %edi
80101e3b:	56                   	push   %esi
80101e3c:	53                   	push   %ebx
80101e3d:	e8 0e fb ff ff       	call   80101950 <readi>
80101e42:	83 c4 10             	add    $0x10,%esp
80101e45:	83 f8 10             	cmp    $0x10,%eax
80101e48:	75 4e                	jne    80101e98 <dirlink+0x98>
80101e4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e4f:	75 df                	jne    80101e30 <dirlink+0x30>
80101e51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e54:	83 ec 04             	sub    $0x4,%esp
80101e57:	6a 0e                	push   $0xe
80101e59:	ff 75 0c             	pushl  0xc(%ebp)
80101e5c:	50                   	push   %eax
80101e5d:	e8 ee 28 00 00       	call   80104750 <strncpy>
80101e62:	8b 45 10             	mov    0x10(%ebp),%eax
80101e65:	6a 10                	push   $0x10
80101e67:	57                   	push   %edi
80101e68:	56                   	push   %esi
80101e69:	53                   	push   %ebx
80101e6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
80101e6e:	e8 dd fb ff ff       	call   80101a50 <writei>
80101e73:	83 c4 20             	add    $0x20,%esp
80101e76:	83 f8 10             	cmp    $0x10,%eax
80101e79:	75 2a                	jne    80101ea5 <dirlink+0xa5>
80101e7b:	31 c0                	xor    %eax,%eax
80101e7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e80:	5b                   	pop    %ebx
80101e81:	5e                   	pop    %esi
80101e82:	5f                   	pop    %edi
80101e83:	5d                   	pop    %ebp
80101e84:	c3                   	ret    
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	50                   	push   %eax
80101e89:	e8 12 f9 ff ff       	call   801017a0 <iput>
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e96:	eb e5                	jmp    80101e7d <dirlink+0x7d>
80101e98:	83 ec 0c             	sub    $0xc,%esp
80101e9b:	68 28 72 10 80       	push   $0x80107228
80101ea0:	e8 cb e4 ff ff       	call   80100370 <panic>
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 a6 78 10 80       	push   $0x801078a6
80101ead:	e8 be e4 ff ff       	call   80100370 <panic>
80101eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <namei>:
80101ec0:	55                   	push   %ebp
80101ec1:	31 d2                	xor    %edx,%edx
80101ec3:	89 e5                	mov    %esp,%ebp
80101ec5:	83 ec 18             	sub    $0x18,%esp
80101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ece:	e8 7d fd ff ff       	call   80101c50 <namex>
80101ed3:	c9                   	leave  
80101ed4:	c3                   	ret    
80101ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <nameiparent>:
80101ee0:	55                   	push   %ebp
80101ee1:	ba 01 00 00 00       	mov    $0x1,%edx
80101ee6:	89 e5                	mov    %esp,%ebp
80101ee8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
80101eee:	5d                   	pop    %ebp
80101eef:	e9 5c fd ff ff       	jmp    80101c50 <namex>
80101ef4:	66 90                	xchg   %ax,%ax
80101ef6:	66 90                	xchg   %ax,%ax
80101ef8:	66 90                	xchg   %ax,%ax
80101efa:	66 90                	xchg   %ax,%ax
80101efc:	66 90                	xchg   %ax,%ax
80101efe:	66 90                	xchg   %ax,%ax

80101f00 <idestart>:
80101f00:	55                   	push   %ebp
80101f01:	85 c0                	test   %eax,%eax
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	56                   	push   %esi
80101f06:	53                   	push   %ebx
80101f07:	0f 84 ad 00 00 00    	je     80101fba <idestart+0xba>
80101f0d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f10:	89 c1                	mov    %eax,%ecx
80101f12:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f18:	0f 87 8f 00 00 00    	ja     80101fad <idestart+0xad>
80101f1e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f23:	90                   	nop
80101f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f28:	ec                   	in     (%dx),%al
80101f29:	83 e0 c0             	and    $0xffffffc0,%eax
80101f2c:	3c 40                	cmp    $0x40,%al
80101f2e:	75 f8                	jne    80101f28 <idestart+0x28>
80101f30:	31 f6                	xor    %esi,%esi
80101f32:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f37:	89 f0                	mov    %esi,%eax
80101f39:	ee                   	out    %al,(%dx)
80101f3a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f3f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f44:	ee                   	out    %al,(%dx)
80101f45:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f4a:	89 d8                	mov    %ebx,%eax
80101f4c:	ee                   	out    %al,(%dx)
80101f4d:	89 d8                	mov    %ebx,%eax
80101f4f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f54:	c1 f8 08             	sar    $0x8,%eax
80101f57:	ee                   	out    %al,(%dx)
80101f58:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f5d:	89 f0                	mov    %esi,%eax
80101f5f:	ee                   	out    %al,(%dx)
80101f60:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f64:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f69:	83 e0 01             	and    $0x1,%eax
80101f6c:	c1 e0 04             	shl    $0x4,%eax
80101f6f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f72:	ee                   	out    %al,(%dx)
80101f73:	f6 01 04             	testb  $0x4,(%ecx)
80101f76:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f7b:	75 13                	jne    80101f90 <idestart+0x90>
80101f7d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f82:	ee                   	out    %al,(%dx)
80101f83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f86:	5b                   	pop    %ebx
80101f87:	5e                   	pop    %esi
80101f88:	5d                   	pop    %ebp
80101f89:	c3                   	ret    
80101f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f90:	b8 30 00 00 00       	mov    $0x30,%eax
80101f95:	ee                   	out    %al,(%dx)
80101f96:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101f9b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f9e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fa3:	fc                   	cld    
80101fa4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80101fa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fa9:	5b                   	pop    %ebx
80101faa:	5e                   	pop    %esi
80101fab:	5d                   	pop    %ebp
80101fac:	c3                   	ret    
80101fad:	83 ec 0c             	sub    $0xc,%esp
80101fb0:	68 94 72 10 80       	push   $0x80107294
80101fb5:	e8 b6 e3 ff ff       	call   80100370 <panic>
80101fba:	83 ec 0c             	sub    $0xc,%esp
80101fbd:	68 8b 72 10 80       	push   $0x8010728b
80101fc2:	e8 a9 e3 ff ff       	call   80100370 <panic>
80101fc7:	89 f6                	mov    %esi,%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <ideinit>:
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	83 ec 10             	sub    $0x10,%esp
80101fd6:	68 a6 72 10 80       	push   $0x801072a6
80101fdb:	68 80 a5 10 80       	push   $0x8010a580
80101fe0:	e8 5b 23 00 00       	call   80104340 <initlock>
80101fe5:	58                   	pop    %eax
80101fe6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80101feb:	5a                   	pop    %edx
80101fec:	83 e8 01             	sub    $0x1,%eax
80101fef:	50                   	push   %eax
80101ff0:	6a 0e                	push   $0xe
80101ff2:	e8 a9 02 00 00       	call   801022a0 <ioapicenable>
80101ff7:	83 c4 10             	add    $0x10,%esp
80101ffa:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fff:	90                   	nop
80102000:	ec                   	in     (%dx),%al
80102001:	83 e0 c0             	and    $0xffffffc0,%eax
80102004:	3c 40                	cmp    $0x40,%al
80102006:	75 f8                	jne    80102000 <ideinit+0x30>
80102008:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010200d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102012:	ee                   	out    %al,(%dx)
80102013:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102018:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010201d:	eb 06                	jmp    80102025 <ideinit+0x55>
8010201f:	90                   	nop
80102020:	83 e9 01             	sub    $0x1,%ecx
80102023:	74 0f                	je     80102034 <ideinit+0x64>
80102025:	ec                   	in     (%dx),%al
80102026:	84 c0                	test   %al,%al
80102028:	74 f6                	je     80102020 <ideinit+0x50>
8010202a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102031:	00 00 00 
80102034:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102039:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010203e:	ee                   	out    %al,(%dx)
8010203f:	c9                   	leave  
80102040:	c3                   	ret    
80102041:	eb 0d                	jmp    80102050 <ideintr>
80102043:	90                   	nop
80102044:	90                   	nop
80102045:	90                   	nop
80102046:	90                   	nop
80102047:	90                   	nop
80102048:	90                   	nop
80102049:	90                   	nop
8010204a:	90                   	nop
8010204b:	90                   	nop
8010204c:	90                   	nop
8010204d:	90                   	nop
8010204e:	90                   	nop
8010204f:	90                   	nop

80102050 <ideintr>:
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	57                   	push   %edi
80102054:	56                   	push   %esi
80102055:	53                   	push   %ebx
80102056:	83 ec 18             	sub    $0x18,%esp
80102059:	68 80 a5 10 80       	push   $0x8010a580
8010205e:	e8 dd 23 00 00       	call   80104440 <acquire>
80102063:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102069:	83 c4 10             	add    $0x10,%esp
8010206c:	85 db                	test   %ebx,%ebx
8010206e:	74 34                	je     801020a4 <ideintr+0x54>
80102070:	8b 43 58             	mov    0x58(%ebx),%eax
80102073:	a3 64 a5 10 80       	mov    %eax,0x8010a564
80102078:	8b 33                	mov    (%ebx),%esi
8010207a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102080:	74 3e                	je     801020c0 <ideintr+0x70>
80102082:	83 e6 fb             	and    $0xfffffffb,%esi
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	83 ce 02             	or     $0x2,%esi
8010208b:	89 33                	mov    %esi,(%ebx)
8010208d:	53                   	push   %ebx
8010208e:	e8 dd 1e 00 00       	call   80103f70 <wakeup>
80102093:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102098:	83 c4 10             	add    $0x10,%esp
8010209b:	85 c0                	test   %eax,%eax
8010209d:	74 05                	je     801020a4 <ideintr+0x54>
8010209f:	e8 5c fe ff ff       	call   80101f00 <idestart>
801020a4:	83 ec 0c             	sub    $0xc,%esp
801020a7:	68 80 a5 10 80       	push   $0x8010a580
801020ac:	e8 af 24 00 00       	call   80104560 <release>
801020b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b4:	5b                   	pop    %ebx
801020b5:	5e                   	pop    %esi
801020b6:	5f                   	pop    %edi
801020b7:	5d                   	pop    %ebp
801020b8:	c3                   	ret    
801020b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020c0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020c5:	8d 76 00             	lea    0x0(%esi),%esi
801020c8:	ec                   	in     (%dx),%al
801020c9:	89 c1                	mov    %eax,%ecx
801020cb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ce:	80 f9 40             	cmp    $0x40,%cl
801020d1:	75 f5                	jne    801020c8 <ideintr+0x78>
801020d3:	a8 21                	test   $0x21,%al
801020d5:	75 ab                	jne    80102082 <ideintr+0x32>
801020d7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
801020da:	b9 80 00 00 00       	mov    $0x80,%ecx
801020df:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020e4:	fc                   	cld    
801020e5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e7:	8b 33                	mov    (%ebx),%esi
801020e9:	eb 97                	jmp    80102082 <ideintr+0x32>
801020eb:	90                   	nop
801020ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020f0 <iderw>:
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	53                   	push   %ebx
801020f4:	83 ec 10             	sub    $0x10,%esp
801020f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801020fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801020fd:	50                   	push   %eax
801020fe:	e8 0d 22 00 00       	call   80104310 <holdingsleep>
80102103:	83 c4 10             	add    $0x10,%esp
80102106:	85 c0                	test   %eax,%eax
80102108:	0f 84 ad 00 00 00    	je     801021bb <iderw+0xcb>
8010210e:	8b 03                	mov    (%ebx),%eax
80102110:	83 e0 06             	and    $0x6,%eax
80102113:	83 f8 02             	cmp    $0x2,%eax
80102116:	0f 84 b9 00 00 00    	je     801021d5 <iderw+0xe5>
8010211c:	8b 53 04             	mov    0x4(%ebx),%edx
8010211f:	85 d2                	test   %edx,%edx
80102121:	74 0d                	je     80102130 <iderw+0x40>
80102123:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102128:	85 c0                	test   %eax,%eax
8010212a:	0f 84 98 00 00 00    	je     801021c8 <iderw+0xd8>
80102130:	83 ec 0c             	sub    $0xc,%esp
80102133:	68 80 a5 10 80       	push   $0x8010a580
80102138:	e8 03 23 00 00       	call   80104440 <acquire>
8010213d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102143:	83 c4 10             	add    $0x10,%esp
80102146:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
8010214d:	85 d2                	test   %edx,%edx
8010214f:	75 09                	jne    8010215a <iderw+0x6a>
80102151:	eb 58                	jmp    801021ab <iderw+0xbb>
80102153:	90                   	nop
80102154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102158:	89 c2                	mov    %eax,%edx
8010215a:	8b 42 58             	mov    0x58(%edx),%eax
8010215d:	85 c0                	test   %eax,%eax
8010215f:	75 f7                	jne    80102158 <iderw+0x68>
80102161:	83 c2 58             	add    $0x58,%edx
80102164:	89 1a                	mov    %ebx,(%edx)
80102166:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010216c:	74 44                	je     801021b2 <iderw+0xc2>
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 e0 06             	and    $0x6,%eax
80102173:	83 f8 02             	cmp    $0x2,%eax
80102176:	74 23                	je     8010219b <iderw+0xab>
80102178:	90                   	nop
80102179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102180:	83 ec 08             	sub    $0x8,%esp
80102183:	68 80 a5 10 80       	push   $0x8010a580
80102188:	53                   	push   %ebx
80102189:	e8 32 1c 00 00       	call   80103dc0 <sleep>
8010218e:	8b 03                	mov    (%ebx),%eax
80102190:	83 c4 10             	add    $0x10,%esp
80102193:	83 e0 06             	and    $0x6,%eax
80102196:	83 f8 02             	cmp    $0x2,%eax
80102199:	75 e5                	jne    80102180 <iderw+0x90>
8010219b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
801021a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021a5:	c9                   	leave  
801021a6:	e9 b5 23 00 00       	jmp    80104560 <release>
801021ab:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021b0:	eb b2                	jmp    80102164 <iderw+0x74>
801021b2:	89 d8                	mov    %ebx,%eax
801021b4:	e8 47 fd ff ff       	call   80101f00 <idestart>
801021b9:	eb b3                	jmp    8010216e <iderw+0x7e>
801021bb:	83 ec 0c             	sub    $0xc,%esp
801021be:	68 aa 72 10 80       	push   $0x801072aa
801021c3:	e8 a8 e1 ff ff       	call   80100370 <panic>
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 d5 72 10 80       	push   $0x801072d5
801021d0:	e8 9b e1 ff ff       	call   80100370 <panic>
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 c0 72 10 80       	push   $0x801072c0
801021dd:	e8 8e e1 ff ff       	call   80100370 <panic>
801021e2:	66 90                	xchg   %ax,%ax
801021e4:	66 90                	xchg   %ax,%ax
801021e6:	66 90                	xchg   %ax,%ax
801021e8:	66 90                	xchg   %ax,%ax
801021ea:	66 90                	xchg   %ax,%ax
801021ec:	66 90                	xchg   %ax,%ax
801021ee:	66 90                	xchg   %ax,%ax

801021f0 <ioapicinit>:
801021f0:	55                   	push   %ebp
801021f1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801021f8:	00 c0 fe 
801021fb:	89 e5                	mov    %esp,%ebp
801021fd:	56                   	push   %esi
801021fe:	53                   	push   %ebx
801021ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102206:	00 00 00 
80102209:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010220f:	8b 72 10             	mov    0x10(%edx),%esi
80102212:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80102218:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010221e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
80102225:	89 f0                	mov    %esi,%eax
80102227:	c1 e8 10             	shr    $0x10,%eax
8010222a:	0f b6 f0             	movzbl %al,%esi
8010222d:	8b 41 10             	mov    0x10(%ecx),%eax
80102230:	c1 e8 18             	shr    $0x18,%eax
80102233:	39 d0                	cmp    %edx,%eax
80102235:	74 16                	je     8010224d <ioapicinit+0x5d>
80102237:	83 ec 0c             	sub    $0xc,%esp
8010223a:	68 f4 72 10 80       	push   $0x801072f4
8010223f:	e8 1c e4 ff ff       	call   80100660 <cprintf>
80102244:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010224a:	83 c4 10             	add    $0x10,%esp
8010224d:	83 c6 21             	add    $0x21,%esi
80102250:	ba 10 00 00 00       	mov    $0x10,%edx
80102255:	b8 20 00 00 00       	mov    $0x20,%eax
8010225a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102260:	89 11                	mov    %edx,(%ecx)
80102262:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102268:	89 c3                	mov    %eax,%ebx
8010226a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102270:	83 c0 01             	add    $0x1,%eax
80102273:	89 59 10             	mov    %ebx,0x10(%ecx)
80102276:	8d 5a 01             	lea    0x1(%edx),%ebx
80102279:	83 c2 02             	add    $0x2,%edx
8010227c:	39 f0                	cmp    %esi,%eax
8010227e:	89 19                	mov    %ebx,(%ecx)
80102280:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102286:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
8010228d:	75 d1                	jne    80102260 <ioapicinit+0x70>
8010228f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102292:	5b                   	pop    %ebx
80102293:	5e                   	pop    %esi
80102294:	5d                   	pop    %ebp
80102295:	c3                   	ret    
80102296:	8d 76 00             	lea    0x0(%esi),%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022a0 <ioapicenable>:
801022a0:	55                   	push   %ebp
801022a1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022a7:	89 e5                	mov    %esp,%ebp
801022a9:	8b 45 08             	mov    0x8(%ebp),%eax
801022ac:	8d 50 20             	lea    0x20(%eax),%edx
801022af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
801022b3:	89 01                	mov    %eax,(%ecx)
801022b5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022bb:	83 c0 01             	add    $0x1,%eax
801022be:	89 51 10             	mov    %edx,0x10(%ecx)
801022c1:	8b 55 0c             	mov    0xc(%ebp),%edx
801022c4:	89 01                	mov    %eax,(%ecx)
801022c6:	a1 34 26 11 80       	mov    0x80112634,%eax
801022cb:	c1 e2 18             	shl    $0x18,%edx
801022ce:	89 50 10             	mov    %edx,0x10(%eax)
801022d1:	5d                   	pop    %ebp
801022d2:	c3                   	ret    
801022d3:	66 90                	xchg   %ax,%ax
801022d5:	66 90                	xchg   %ax,%ax
801022d7:	66 90                	xchg   %ax,%ax
801022d9:	66 90                	xchg   %ax,%ax
801022db:	66 90                	xchg   %ax,%ax
801022dd:	66 90                	xchg   %ax,%ax
801022df:	90                   	nop

801022e0 <kfree>:
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 04             	sub    $0x4,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801022ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022f0:	75 70                	jne    80102362 <kfree+0x82>
801022f2:	81 fb a8 55 11 80    	cmp    $0x801155a8,%ebx
801022f8:	72 68                	jb     80102362 <kfree+0x82>
801022fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102300:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102305:	77 5b                	ja     80102362 <kfree+0x82>
80102307:	83 ec 04             	sub    $0x4,%esp
8010230a:	68 00 10 00 00       	push   $0x1000
8010230f:	6a 01                	push   $0x1
80102311:	53                   	push   %ebx
80102312:	e8 99 22 00 00       	call   801045b0 <memset>
80102317:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010231d:	83 c4 10             	add    $0x10,%esp
80102320:	85 d2                	test   %edx,%edx
80102322:	75 2c                	jne    80102350 <kfree+0x70>
80102324:	a1 78 26 11 80       	mov    0x80112678,%eax
80102329:	89 03                	mov    %eax,(%ebx)
8010232b:	a1 74 26 11 80       	mov    0x80112674,%eax
80102330:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
80102336:	85 c0                	test   %eax,%eax
80102338:	75 06                	jne    80102340 <kfree+0x60>
8010233a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233d:	c9                   	leave  
8010233e:	c3                   	ret    
8010233f:	90                   	nop
80102340:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
80102347:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010234a:	c9                   	leave  
8010234b:	e9 10 22 00 00       	jmp    80104560 <release>
80102350:	83 ec 0c             	sub    $0xc,%esp
80102353:	68 40 26 11 80       	push   $0x80112640
80102358:	e8 e3 20 00 00       	call   80104440 <acquire>
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	eb c2                	jmp    80102324 <kfree+0x44>
80102362:	83 ec 0c             	sub    $0xc,%esp
80102365:	68 26 73 10 80       	push   $0x80107326
8010236a:	e8 01 e0 ff ff       	call   80100370 <panic>
8010236f:	90                   	nop

80102370 <freerange>:
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	56                   	push   %esi
80102374:	53                   	push   %ebx
80102375:	8b 45 08             	mov    0x8(%ebp),%eax
80102378:	8b 75 0c             	mov    0xc(%ebp),%esi
8010237b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102381:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102387:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010238d:	39 de                	cmp    %ebx,%esi
8010238f:	72 23                	jb     801023b4 <freerange+0x44>
80102391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102398:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010239e:	83 ec 0c             	sub    $0xc,%esp
801023a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023a7:	50                   	push   %eax
801023a8:	e8 33 ff ff ff       	call   801022e0 <kfree>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	39 f3                	cmp    %esi,%ebx
801023b2:	76 e4                	jbe    80102398 <freerange+0x28>
801023b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023b7:	5b                   	pop    %ebx
801023b8:	5e                   	pop    %esi
801023b9:	5d                   	pop    %ebp
801023ba:	c3                   	ret    
801023bb:	90                   	nop
801023bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023c0 <kinit1>:
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
801023c5:	8b 75 0c             	mov    0xc(%ebp),%esi
801023c8:	83 ec 08             	sub    $0x8,%esp
801023cb:	68 2c 73 10 80       	push   $0x8010732c
801023d0:	68 40 26 11 80       	push   $0x80112640
801023d5:	e8 66 1f 00 00       	call   80104340 <initlock>
801023da:	8b 45 08             	mov    0x8(%ebp),%eax
801023dd:	83 c4 10             	add    $0x10,%esp
801023e0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801023e7:	00 00 00 
801023ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801023f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023fc:	39 de                	cmp    %ebx,%esi
801023fe:	72 1c                	jb     8010241c <kinit1+0x5c>
80102400:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102406:	83 ec 0c             	sub    $0xc,%esp
80102409:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010240f:	50                   	push   %eax
80102410:	e8 cb fe ff ff       	call   801022e0 <kfree>
80102415:	83 c4 10             	add    $0x10,%esp
80102418:	39 de                	cmp    %ebx,%esi
8010241a:	73 e4                	jae    80102400 <kinit1+0x40>
8010241c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010241f:	5b                   	pop    %ebx
80102420:	5e                   	pop    %esi
80102421:	5d                   	pop    %ebp
80102422:	c3                   	ret    
80102423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102430 <kinit2>:
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	56                   	push   %esi
80102434:	53                   	push   %ebx
80102435:	8b 45 08             	mov    0x8(%ebp),%eax
80102438:	8b 75 0c             	mov    0xc(%ebp),%esi
8010243b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102441:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102447:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244d:	39 de                	cmp    %ebx,%esi
8010244f:	72 23                	jb     80102474 <kinit2+0x44>
80102451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102458:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010245e:	83 ec 0c             	sub    $0xc,%esp
80102461:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102467:	50                   	push   %eax
80102468:	e8 73 fe ff ff       	call   801022e0 <kfree>
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 e4                	jae    80102458 <kinit2+0x28>
80102474:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010247b:	00 00 00 
8010247e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102481:	5b                   	pop    %ebx
80102482:	5e                   	pop    %esi
80102483:	5d                   	pop    %ebp
80102484:	c3                   	ret    
80102485:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kalloc>:
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	53                   	push   %ebx
80102494:	83 ec 04             	sub    $0x4,%esp
80102497:	a1 74 26 11 80       	mov    0x80112674,%eax
8010249c:	85 c0                	test   %eax,%eax
8010249e:	75 30                	jne    801024d0 <kalloc+0x40>
801024a0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
801024a6:	85 db                	test   %ebx,%ebx
801024a8:	74 1c                	je     801024c6 <kalloc+0x36>
801024aa:	8b 13                	mov    (%ebx),%edx
801024ac:	89 15 78 26 11 80    	mov    %edx,0x80112678
801024b2:	85 c0                	test   %eax,%eax
801024b4:	74 10                	je     801024c6 <kalloc+0x36>
801024b6:	83 ec 0c             	sub    $0xc,%esp
801024b9:	68 40 26 11 80       	push   $0x80112640
801024be:	e8 9d 20 00 00       	call   80104560 <release>
801024c3:	83 c4 10             	add    $0x10,%esp
801024c6:	89 d8                	mov    %ebx,%eax
801024c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024cb:	c9                   	leave  
801024cc:	c3                   	ret    
801024cd:	8d 76 00             	lea    0x0(%esi),%esi
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 40 26 11 80       	push   $0x80112640
801024d8:	e8 63 1f 00 00       	call   80104440 <acquire>
801024dd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
801024e3:	83 c4 10             	add    $0x10,%esp
801024e6:	a1 74 26 11 80       	mov    0x80112674,%eax
801024eb:	85 db                	test   %ebx,%ebx
801024ed:	75 bb                	jne    801024aa <kalloc+0x1a>
801024ef:	eb c1                	jmp    801024b2 <kalloc+0x22>
801024f1:	66 90                	xchg   %ax,%ax
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kbdgetc>:
80102500:	55                   	push   %ebp
80102501:	ba 64 00 00 00       	mov    $0x64,%edx
80102506:	89 e5                	mov    %esp,%ebp
80102508:	ec                   	in     (%dx),%al
80102509:	a8 01                	test   $0x1,%al
8010250b:	0f 84 af 00 00 00    	je     801025c0 <kbdgetc+0xc0>
80102511:	ba 60 00 00 00       	mov    $0x60,%edx
80102516:	ec                   	in     (%dx),%al
80102517:	0f b6 d0             	movzbl %al,%edx
8010251a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102520:	74 7e                	je     801025a0 <kbdgetc+0xa0>
80102522:	84 c0                	test   %al,%al
80102524:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
8010252a:	79 24                	jns    80102550 <kbdgetc+0x50>
8010252c:	f6 c1 40             	test   $0x40,%cl
8010252f:	75 05                	jne    80102536 <kbdgetc+0x36>
80102531:	89 c2                	mov    %eax,%edx
80102533:	83 e2 7f             	and    $0x7f,%edx
80102536:	0f b6 82 60 74 10 80 	movzbl -0x7fef8ba0(%edx),%eax
8010253d:	83 c8 40             	or     $0x40,%eax
80102540:	0f b6 c0             	movzbl %al,%eax
80102543:	f7 d0                	not    %eax
80102545:	21 c8                	and    %ecx,%eax
80102547:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
8010254c:	31 c0                	xor    %eax,%eax
8010254e:	5d                   	pop    %ebp
8010254f:	c3                   	ret    
80102550:	f6 c1 40             	test   $0x40,%cl
80102553:	74 09                	je     8010255e <kbdgetc+0x5e>
80102555:	83 c8 80             	or     $0xffffff80,%eax
80102558:	83 e1 bf             	and    $0xffffffbf,%ecx
8010255b:	0f b6 d0             	movzbl %al,%edx
8010255e:	0f b6 82 60 74 10 80 	movzbl -0x7fef8ba0(%edx),%eax
80102565:	09 c1                	or     %eax,%ecx
80102567:	0f b6 82 60 73 10 80 	movzbl -0x7fef8ca0(%edx),%eax
8010256e:	31 c1                	xor    %eax,%ecx
80102570:	89 c8                	mov    %ecx,%eax
80102572:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
80102578:	83 e0 03             	and    $0x3,%eax
8010257b:	83 e1 08             	and    $0x8,%ecx
8010257e:	8b 04 85 40 73 10 80 	mov    -0x7fef8cc0(,%eax,4),%eax
80102585:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
80102589:	74 c3                	je     8010254e <kbdgetc+0x4e>
8010258b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010258e:	83 fa 19             	cmp    $0x19,%edx
80102591:	77 1d                	ja     801025b0 <kbdgetc+0xb0>
80102593:	83 e8 20             	sub    $0x20,%eax
80102596:	5d                   	pop    %ebp
80102597:	c3                   	ret    
80102598:	90                   	nop
80102599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025a0:	31 c0                	xor    %eax,%eax
801025a2:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
801025a9:	5d                   	pop    %ebp
801025aa:	c3                   	ret    
801025ab:	90                   	nop
801025ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025b0:	8d 48 bf             	lea    -0x41(%eax),%ecx
801025b3:	8d 50 20             	lea    0x20(%eax),%edx
801025b6:	5d                   	pop    %ebp
801025b7:	83 f9 19             	cmp    $0x19,%ecx
801025ba:	0f 46 c2             	cmovbe %edx,%eax
801025bd:	c3                   	ret    
801025be:	66 90                	xchg   %ax,%ax
801025c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025c5:	5d                   	pop    %ebp
801025c6:	c3                   	ret    
801025c7:	89 f6                	mov    %esi,%esi
801025c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025d0 <kbdintr>:
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	83 ec 14             	sub    $0x14,%esp
801025d6:	68 00 25 10 80       	push   $0x80102500
801025db:	e8 10 e2 ff ff       	call   801007f0 <consoleintr>
801025e0:	83 c4 10             	add    $0x10,%esp
801025e3:	c9                   	leave  
801025e4:	c3                   	ret    
801025e5:	66 90                	xchg   %ax,%ax
801025e7:	66 90                	xchg   %ax,%ax
801025e9:	66 90                	xchg   %ax,%ax
801025eb:	66 90                	xchg   %ax,%ax
801025ed:	66 90                	xchg   %ax,%ax
801025ef:	90                   	nop

801025f0 <lapicinit>:
801025f0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801025f5:	55                   	push   %ebp
801025f6:	89 e5                	mov    %esp,%ebp
801025f8:	85 c0                	test   %eax,%eax
801025fa:	0f 84 c8 00 00 00    	je     801026c8 <lapicinit+0xd8>
80102600:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102607:	01 00 00 
8010260a:	8b 50 20             	mov    0x20(%eax),%edx
8010260d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102614:	00 00 00 
80102617:	8b 50 20             	mov    0x20(%eax),%edx
8010261a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102621:	00 02 00 
80102624:	8b 50 20             	mov    0x20(%eax),%edx
80102627:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010262e:	96 98 00 
80102631:	8b 50 20             	mov    0x20(%eax),%edx
80102634:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010263b:	00 01 00 
8010263e:	8b 50 20             	mov    0x20(%eax),%edx
80102641:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102648:	00 01 00 
8010264b:	8b 50 20             	mov    0x20(%eax),%edx
8010264e:	8b 50 30             	mov    0x30(%eax),%edx
80102651:	c1 ea 10             	shr    $0x10,%edx
80102654:	80 fa 03             	cmp    $0x3,%dl
80102657:	77 77                	ja     801026d0 <lapicinit+0xe0>
80102659:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102660:	00 00 00 
80102663:	8b 50 20             	mov    0x20(%eax),%edx
80102666:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010266d:	00 00 00 
80102670:	8b 50 20             	mov    0x20(%eax),%edx
80102673:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010267a:	00 00 00 
8010267d:	8b 50 20             	mov    0x20(%eax),%edx
80102680:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102687:	00 00 00 
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
8010268d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102694:	00 00 00 
80102697:	8b 50 20             	mov    0x20(%eax),%edx
8010269a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026a1:	85 08 00 
801026a4:	8b 50 20             	mov    0x20(%eax),%edx
801026a7:	89 f6                	mov    %esi,%esi
801026a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801026b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026b6:	80 e6 10             	and    $0x10,%dh
801026b9:	75 f5                	jne    801026b0 <lapicinit+0xc0>
801026bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026c2:	00 00 00 
801026c5:	8b 40 20             	mov    0x20(%eax),%eax
801026c8:	5d                   	pop    %ebp
801026c9:	c3                   	ret    
801026ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801026d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026d7:	00 01 00 
801026da:	8b 50 20             	mov    0x20(%eax),%edx
801026dd:	e9 77 ff ff ff       	jmp    80102659 <lapicinit+0x69>
801026e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <lapicid>:
801026f0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801026f5:	55                   	push   %ebp
801026f6:	89 e5                	mov    %esp,%ebp
801026f8:	85 c0                	test   %eax,%eax
801026fa:	74 0c                	je     80102708 <lapicid+0x18>
801026fc:	8b 40 20             	mov    0x20(%eax),%eax
801026ff:	5d                   	pop    %ebp
80102700:	c1 e8 18             	shr    $0x18,%eax
80102703:	c3                   	ret    
80102704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102708:	31 c0                	xor    %eax,%eax
8010270a:	5d                   	pop    %ebp
8010270b:	c3                   	ret    
8010270c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102710 <lapiceoi>:
80102710:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102715:	55                   	push   %ebp
80102716:	89 e5                	mov    %esp,%ebp
80102718:	85 c0                	test   %eax,%eax
8010271a:	74 0d                	je     80102729 <lapiceoi+0x19>
8010271c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102723:	00 00 00 
80102726:	8b 40 20             	mov    0x20(%eax),%eax
80102729:	5d                   	pop    %ebp
8010272a:	c3                   	ret    
8010272b:	90                   	nop
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102730 <microdelay>:
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	5d                   	pop    %ebp
80102734:	c3                   	ret    
80102735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102740 <lapicstartap>:
80102740:	55                   	push   %ebp
80102741:	ba 70 00 00 00       	mov    $0x70,%edx
80102746:	b8 0f 00 00 00       	mov    $0xf,%eax
8010274b:	89 e5                	mov    %esp,%ebp
8010274d:	53                   	push   %ebx
8010274e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102751:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102754:	ee                   	out    %al,(%dx)
80102755:	ba 71 00 00 00       	mov    $0x71,%edx
8010275a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010275f:	ee                   	out    %al,(%dx)
80102760:	31 c0                	xor    %eax,%eax
80102762:	c1 e3 18             	shl    $0x18,%ebx
80102765:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010276b:	89 c8                	mov    %ecx,%eax
8010276d:	c1 e9 0c             	shr    $0xc,%ecx
80102770:	c1 e8 04             	shr    $0x4,%eax
80102773:	89 da                	mov    %ebx,%edx
80102775:	80 cd 06             	or     $0x6,%ch
80102778:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010277e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102783:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102789:	8b 58 20             	mov    0x20(%eax),%ebx
8010278c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102793:	c5 00 00 
80102796:	8b 58 20             	mov    0x20(%eax),%ebx
80102799:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027a0:	85 00 00 
801027a3:	8b 58 20             	mov    0x20(%eax),%ebx
801027a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801027ac:	8b 58 20             	mov    0x20(%eax),%ebx
801027af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801027b5:	8b 58 20             	mov    0x20(%eax),%ebx
801027b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
801027be:	8b 50 20             	mov    0x20(%eax),%edx
801027c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
801027c7:	8b 40 20             	mov    0x20(%eax),%eax
801027ca:	5b                   	pop    %ebx
801027cb:	5d                   	pop    %ebp
801027cc:	c3                   	ret    
801027cd:	8d 76 00             	lea    0x0(%esi),%esi

801027d0 <cmostime>:
801027d0:	55                   	push   %ebp
801027d1:	ba 70 00 00 00       	mov    $0x70,%edx
801027d6:	b8 0b 00 00 00       	mov    $0xb,%eax
801027db:	89 e5                	mov    %esp,%ebp
801027dd:	57                   	push   %edi
801027de:	56                   	push   %esi
801027df:	53                   	push   %ebx
801027e0:	83 ec 4c             	sub    $0x4c,%esp
801027e3:	ee                   	out    %al,(%dx)
801027e4:	ba 71 00 00 00       	mov    $0x71,%edx
801027e9:	ec                   	in     (%dx),%al
801027ea:	83 e0 04             	and    $0x4,%eax
801027ed:	8d 75 d0             	lea    -0x30(%ebp),%esi
801027f0:	31 db                	xor    %ebx,%ebx
801027f2:	88 45 b7             	mov    %al,-0x49(%ebp)
801027f5:	bf 70 00 00 00       	mov    $0x70,%edi
801027fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102800:	89 d8                	mov    %ebx,%eax
80102802:	89 fa                	mov    %edi,%edx
80102804:	ee                   	out    %al,(%dx)
80102805:	b9 71 00 00 00       	mov    $0x71,%ecx
8010280a:	89 ca                	mov    %ecx,%edx
8010280c:	ec                   	in     (%dx),%al
8010280d:	0f b6 c0             	movzbl %al,%eax
80102810:	89 fa                	mov    %edi,%edx
80102812:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102815:	b8 02 00 00 00       	mov    $0x2,%eax
8010281a:	ee                   	out    %al,(%dx)
8010281b:	89 ca                	mov    %ecx,%edx
8010281d:	ec                   	in     (%dx),%al
8010281e:	0f b6 c0             	movzbl %al,%eax
80102821:	89 fa                	mov    %edi,%edx
80102823:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102826:	b8 04 00 00 00       	mov    $0x4,%eax
8010282b:	ee                   	out    %al,(%dx)
8010282c:	89 ca                	mov    %ecx,%edx
8010282e:	ec                   	in     (%dx),%al
8010282f:	0f b6 c0             	movzbl %al,%eax
80102832:	89 fa                	mov    %edi,%edx
80102834:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102837:	b8 07 00 00 00       	mov    $0x7,%eax
8010283c:	ee                   	out    %al,(%dx)
8010283d:	89 ca                	mov    %ecx,%edx
8010283f:	ec                   	in     (%dx),%al
80102840:	0f b6 c0             	movzbl %al,%eax
80102843:	89 fa                	mov    %edi,%edx
80102845:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102848:	b8 08 00 00 00       	mov    $0x8,%eax
8010284d:	ee                   	out    %al,(%dx)
8010284e:	89 ca                	mov    %ecx,%edx
80102850:	ec                   	in     (%dx),%al
80102851:	0f b6 c0             	movzbl %al,%eax
80102854:	89 fa                	mov    %edi,%edx
80102856:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102859:	b8 09 00 00 00       	mov    $0x9,%eax
8010285e:	ee                   	out    %al,(%dx)
8010285f:	89 ca                	mov    %ecx,%edx
80102861:	ec                   	in     (%dx),%al
80102862:	0f b6 c0             	movzbl %al,%eax
80102865:	89 fa                	mov    %edi,%edx
80102867:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010286a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010286f:	ee                   	out    %al,(%dx)
80102870:	89 ca                	mov    %ecx,%edx
80102872:	ec                   	in     (%dx),%al
80102873:	84 c0                	test   %al,%al
80102875:	78 89                	js     80102800 <cmostime+0x30>
80102877:	89 d8                	mov    %ebx,%eax
80102879:	89 fa                	mov    %edi,%edx
8010287b:	ee                   	out    %al,(%dx)
8010287c:	89 ca                	mov    %ecx,%edx
8010287e:	ec                   	in     (%dx),%al
8010287f:	0f b6 c0             	movzbl %al,%eax
80102882:	89 fa                	mov    %edi,%edx
80102884:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102887:	b8 02 00 00 00       	mov    $0x2,%eax
8010288c:	ee                   	out    %al,(%dx)
8010288d:	89 ca                	mov    %ecx,%edx
8010288f:	ec                   	in     (%dx),%al
80102890:	0f b6 c0             	movzbl %al,%eax
80102893:	89 fa                	mov    %edi,%edx
80102895:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102898:	b8 04 00 00 00       	mov    $0x4,%eax
8010289d:	ee                   	out    %al,(%dx)
8010289e:	89 ca                	mov    %ecx,%edx
801028a0:	ec                   	in     (%dx),%al
801028a1:	0f b6 c0             	movzbl %al,%eax
801028a4:	89 fa                	mov    %edi,%edx
801028a6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028a9:	b8 07 00 00 00       	mov    $0x7,%eax
801028ae:	ee                   	out    %al,(%dx)
801028af:	89 ca                	mov    %ecx,%edx
801028b1:	ec                   	in     (%dx),%al
801028b2:	0f b6 c0             	movzbl %al,%eax
801028b5:	89 fa                	mov    %edi,%edx
801028b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028ba:	b8 08 00 00 00       	mov    $0x8,%eax
801028bf:	ee                   	out    %al,(%dx)
801028c0:	89 ca                	mov    %ecx,%edx
801028c2:	ec                   	in     (%dx),%al
801028c3:	0f b6 c0             	movzbl %al,%eax
801028c6:	89 fa                	mov    %edi,%edx
801028c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028cb:	b8 09 00 00 00       	mov    $0x9,%eax
801028d0:	ee                   	out    %al,(%dx)
801028d1:	89 ca                	mov    %ecx,%edx
801028d3:	ec                   	in     (%dx),%al
801028d4:	0f b6 c0             	movzbl %al,%eax
801028d7:	83 ec 04             	sub    $0x4,%esp
801028da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801028dd:	8d 45 b8             	lea    -0x48(%ebp),%eax
801028e0:	6a 18                	push   $0x18
801028e2:	56                   	push   %esi
801028e3:	50                   	push   %eax
801028e4:	e8 17 1d 00 00       	call   80104600 <memcmp>
801028e9:	83 c4 10             	add    $0x10,%esp
801028ec:	85 c0                	test   %eax,%eax
801028ee:	0f 85 0c ff ff ff    	jne    80102800 <cmostime+0x30>
801028f4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028f8:	75 78                	jne    80102972 <cmostime+0x1a2>
801028fa:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028fd:	89 c2                	mov    %eax,%edx
801028ff:	83 e0 0f             	and    $0xf,%eax
80102902:	c1 ea 04             	shr    $0x4,%edx
80102905:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102908:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010290b:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010290e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102911:	89 c2                	mov    %eax,%edx
80102913:	83 e0 0f             	and    $0xf,%eax
80102916:	c1 ea 04             	shr    $0x4,%edx
80102919:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010291c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010291f:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102922:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102925:	89 c2                	mov    %eax,%edx
80102927:	83 e0 0f             	and    $0xf,%eax
8010292a:	c1 ea 04             	shr    $0x4,%edx
8010292d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102930:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102933:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102936:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102939:	89 c2                	mov    %eax,%edx
8010293b:	83 e0 0f             	and    $0xf,%eax
8010293e:	c1 ea 04             	shr    $0x4,%edx
80102941:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102944:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102947:	89 45 c4             	mov    %eax,-0x3c(%ebp)
8010294a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010294d:	89 c2                	mov    %eax,%edx
8010294f:	83 e0 0f             	and    $0xf,%eax
80102952:	c1 ea 04             	shr    $0x4,%edx
80102955:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102958:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295b:	89 45 c8             	mov    %eax,-0x38(%ebp)
8010295e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102961:	89 c2                	mov    %eax,%edx
80102963:	83 e0 0f             	and    $0xf,%eax
80102966:	c1 ea 04             	shr    $0x4,%edx
80102969:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296f:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102972:	8b 75 08             	mov    0x8(%ebp),%esi
80102975:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102978:	89 06                	mov    %eax,(%esi)
8010297a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010297d:	89 46 04             	mov    %eax,0x4(%esi)
80102980:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102983:	89 46 08             	mov    %eax,0x8(%esi)
80102986:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102989:	89 46 0c             	mov    %eax,0xc(%esi)
8010298c:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010298f:	89 46 10             	mov    %eax,0x10(%esi)
80102992:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102995:	89 46 14             	mov    %eax,0x14(%esi)
80102998:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
8010299f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029a2:	5b                   	pop    %ebx
801029a3:	5e                   	pop    %esi
801029a4:	5f                   	pop    %edi
801029a5:	5d                   	pop    %ebp
801029a6:	c3                   	ret    
801029a7:	66 90                	xchg   %ax,%ax
801029a9:	66 90                	xchg   %ax,%ax
801029ab:	66 90                	xchg   %ax,%ax
801029ad:	66 90                	xchg   %ax,%ax
801029af:	90                   	nop

801029b0 <install_trans>:
801029b0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
801029b6:	85 c9                	test   %ecx,%ecx
801029b8:	0f 8e 85 00 00 00    	jle    80102a43 <install_trans+0x93>
801029be:	55                   	push   %ebp
801029bf:	89 e5                	mov    %esp,%ebp
801029c1:	57                   	push   %edi
801029c2:	56                   	push   %esi
801029c3:	53                   	push   %ebx
801029c4:	31 db                	xor    %ebx,%ebx
801029c6:	83 ec 0c             	sub    $0xc,%esp
801029c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029d0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801029d5:	83 ec 08             	sub    $0x8,%esp
801029d8:	01 d8                	add    %ebx,%eax
801029da:	83 c0 01             	add    $0x1,%eax
801029dd:	50                   	push   %eax
801029de:	ff 35 c4 26 11 80    	pushl  0x801126c4
801029e4:	e8 e7 d6 ff ff       	call   801000d0 <bread>
801029e9:	89 c7                	mov    %eax,%edi
801029eb:	58                   	pop    %eax
801029ec:	5a                   	pop    %edx
801029ed:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
801029f4:	ff 35 c4 26 11 80    	pushl  0x801126c4
801029fa:	83 c3 01             	add    $0x1,%ebx
801029fd:	e8 ce d6 ff ff       	call   801000d0 <bread>
80102a02:	89 c6                	mov    %eax,%esi
80102a04:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a07:	83 c4 0c             	add    $0xc,%esp
80102a0a:	68 00 02 00 00       	push   $0x200
80102a0f:	50                   	push   %eax
80102a10:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a13:	50                   	push   %eax
80102a14:	e8 47 1c 00 00       	call   80104660 <memmove>
80102a19:	89 34 24             	mov    %esi,(%esp)
80102a1c:	e8 7f d7 ff ff       	call   801001a0 <bwrite>
80102a21:	89 3c 24             	mov    %edi,(%esp)
80102a24:	e8 b7 d7 ff ff       	call   801001e0 <brelse>
80102a29:	89 34 24             	mov    %esi,(%esp)
80102a2c:	e8 af d7 ff ff       	call   801001e0 <brelse>
80102a31:	83 c4 10             	add    $0x10,%esp
80102a34:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102a3a:	7f 94                	jg     801029d0 <install_trans+0x20>
80102a3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a3f:	5b                   	pop    %ebx
80102a40:	5e                   	pop    %esi
80102a41:	5f                   	pop    %edi
80102a42:	5d                   	pop    %ebp
80102a43:	f3 c3                	repz ret 
80102a45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a50 <write_head>:
80102a50:	55                   	push   %ebp
80102a51:	89 e5                	mov    %esp,%ebp
80102a53:	53                   	push   %ebx
80102a54:	83 ec 0c             	sub    $0xc,%esp
80102a57:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102a5d:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a63:	e8 68 d6 ff ff       	call   801000d0 <bread>
80102a68:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102a6e:	83 c4 10             	add    $0x10,%esp
80102a71:	89 c3                	mov    %eax,%ebx
80102a73:	85 c9                	test   %ecx,%ecx
80102a75:	89 48 5c             	mov    %ecx,0x5c(%eax)
80102a78:	7e 1f                	jle    80102a99 <write_head+0x49>
80102a7a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102a81:	31 d2                	xor    %edx,%edx
80102a83:	90                   	nop
80102a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a88:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102a8e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102a92:	83 c2 04             	add    $0x4,%edx
80102a95:	39 c2                	cmp    %eax,%edx
80102a97:	75 ef                	jne    80102a88 <write_head+0x38>
80102a99:	83 ec 0c             	sub    $0xc,%esp
80102a9c:	53                   	push   %ebx
80102a9d:	e8 fe d6 ff ff       	call   801001a0 <bwrite>
80102aa2:	89 1c 24             	mov    %ebx,(%esp)
80102aa5:	e8 36 d7 ff ff       	call   801001e0 <brelse>
80102aaa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102aad:	c9                   	leave  
80102aae:	c3                   	ret    
80102aaf:	90                   	nop

80102ab0 <initlog>:
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	53                   	push   %ebx
80102ab4:	83 ec 2c             	sub    $0x2c,%esp
80102ab7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102aba:	68 60 75 10 80       	push   $0x80107560
80102abf:	68 80 26 11 80       	push   $0x80112680
80102ac4:	e8 77 18 00 00       	call   80104340 <initlock>
80102ac9:	58                   	pop    %eax
80102aca:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102acd:	5a                   	pop    %edx
80102ace:	50                   	push   %eax
80102acf:	53                   	push   %ebx
80102ad0:	e8 db e8 ff ff       	call   801013b0 <readsb>
80102ad5:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102ad8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102adb:	59                   	pop    %ecx
80102adc:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
80102ae2:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
80102ae8:	a3 b4 26 11 80       	mov    %eax,0x801126b4
80102aed:	5a                   	pop    %edx
80102aee:	50                   	push   %eax
80102aef:	53                   	push   %ebx
80102af0:	e8 db d5 ff ff       	call   801000d0 <bread>
80102af5:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102af8:	83 c4 10             	add    $0x10,%esp
80102afb:	85 c9                	test   %ecx,%ecx
80102afd:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
80102b03:	7e 1c                	jle    80102b21 <initlog+0x71>
80102b05:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b0c:	31 d2                	xor    %edx,%edx
80102b0e:	66 90                	xchg   %ax,%ax
80102b10:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b14:	83 c2 04             	add    $0x4,%edx
80102b17:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
80102b1d:	39 da                	cmp    %ebx,%edx
80102b1f:	75 ef                	jne    80102b10 <initlog+0x60>
80102b21:	83 ec 0c             	sub    $0xc,%esp
80102b24:	50                   	push   %eax
80102b25:	e8 b6 d6 ff ff       	call   801001e0 <brelse>
80102b2a:	e8 81 fe ff ff       	call   801029b0 <install_trans>
80102b2f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102b36:	00 00 00 
80102b39:	e8 12 ff ff ff       	call   80102a50 <write_head>
80102b3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b41:	c9                   	leave  
80102b42:	c3                   	ret    
80102b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b50 <begin_op>:
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	83 ec 14             	sub    $0x14,%esp
80102b56:	68 80 26 11 80       	push   $0x80112680
80102b5b:	e8 e0 18 00 00       	call   80104440 <acquire>
80102b60:	83 c4 10             	add    $0x10,%esp
80102b63:	eb 18                	jmp    80102b7d <begin_op+0x2d>
80102b65:	8d 76 00             	lea    0x0(%esi),%esi
80102b68:	83 ec 08             	sub    $0x8,%esp
80102b6b:	68 80 26 11 80       	push   $0x80112680
80102b70:	68 80 26 11 80       	push   $0x80112680
80102b75:	e8 46 12 00 00       	call   80103dc0 <sleep>
80102b7a:	83 c4 10             	add    $0x10,%esp
80102b7d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102b82:	85 c0                	test   %eax,%eax
80102b84:	75 e2                	jne    80102b68 <begin_op+0x18>
80102b86:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102b8b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102b91:	83 c0 01             	add    $0x1,%eax
80102b94:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b97:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b9a:	83 fa 1e             	cmp    $0x1e,%edx
80102b9d:	7f c9                	jg     80102b68 <begin_op+0x18>
80102b9f:	83 ec 0c             	sub    $0xc,%esp
80102ba2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
80102ba7:	68 80 26 11 80       	push   $0x80112680
80102bac:	e8 af 19 00 00       	call   80104560 <release>
80102bb1:	83 c4 10             	add    $0x10,%esp
80102bb4:	c9                   	leave  
80102bb5:	c3                   	ret    
80102bb6:	8d 76 00             	lea    0x0(%esi),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bc0 <end_op>:
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	57                   	push   %edi
80102bc4:	56                   	push   %esi
80102bc5:	53                   	push   %ebx
80102bc6:	83 ec 18             	sub    $0x18,%esp
80102bc9:	68 80 26 11 80       	push   $0x80112680
80102bce:	e8 6d 18 00 00       	call   80104440 <acquire>
80102bd3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102bd8:	8b 1d c0 26 11 80    	mov    0x801126c0,%ebx
80102bde:	83 c4 10             	add    $0x10,%esp
80102be1:	83 e8 01             	sub    $0x1,%eax
80102be4:	85 db                	test   %ebx,%ebx
80102be6:	a3 bc 26 11 80       	mov    %eax,0x801126bc
80102beb:	0f 85 23 01 00 00    	jne    80102d14 <end_op+0x154>
80102bf1:	85 c0                	test   %eax,%eax
80102bf3:	0f 85 f7 00 00 00    	jne    80102cf0 <end_op+0x130>
80102bf9:	83 ec 0c             	sub    $0xc,%esp
80102bfc:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c03:	00 00 00 
80102c06:	31 db                	xor    %ebx,%ebx
80102c08:	68 80 26 11 80       	push   $0x80112680
80102c0d:	e8 4e 19 00 00       	call   80104560 <release>
80102c12:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c18:	83 c4 10             	add    $0x10,%esp
80102c1b:	85 c9                	test   %ecx,%ecx
80102c1d:	0f 8e 8a 00 00 00    	jle    80102cad <end_op+0xed>
80102c23:	90                   	nop
80102c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c28:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c2d:	83 ec 08             	sub    $0x8,%esp
80102c30:	01 d8                	add    %ebx,%eax
80102c32:	83 c0 01             	add    $0x1,%eax
80102c35:	50                   	push   %eax
80102c36:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102c3c:	e8 8f d4 ff ff       	call   801000d0 <bread>
80102c41:	89 c6                	mov    %eax,%esi
80102c43:	58                   	pop    %eax
80102c44:	5a                   	pop    %edx
80102c45:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102c4c:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102c52:	83 c3 01             	add    $0x1,%ebx
80102c55:	e8 76 d4 ff ff       	call   801000d0 <bread>
80102c5a:	89 c7                	mov    %eax,%edi
80102c5c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c5f:	83 c4 0c             	add    $0xc,%esp
80102c62:	68 00 02 00 00       	push   $0x200
80102c67:	50                   	push   %eax
80102c68:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c6b:	50                   	push   %eax
80102c6c:	e8 ef 19 00 00       	call   80104660 <memmove>
80102c71:	89 34 24             	mov    %esi,(%esp)
80102c74:	e8 27 d5 ff ff       	call   801001a0 <bwrite>
80102c79:	89 3c 24             	mov    %edi,(%esp)
80102c7c:	e8 5f d5 ff ff       	call   801001e0 <brelse>
80102c81:	89 34 24             	mov    %esi,(%esp)
80102c84:	e8 57 d5 ff ff       	call   801001e0 <brelse>
80102c89:	83 c4 10             	add    $0x10,%esp
80102c8c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102c92:	7c 94                	jl     80102c28 <end_op+0x68>
80102c94:	e8 b7 fd ff ff       	call   80102a50 <write_head>
80102c99:	e8 12 fd ff ff       	call   801029b0 <install_trans>
80102c9e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102ca5:	00 00 00 
80102ca8:	e8 a3 fd ff ff       	call   80102a50 <write_head>
80102cad:	83 ec 0c             	sub    $0xc,%esp
80102cb0:	68 80 26 11 80       	push   $0x80112680
80102cb5:	e8 86 17 00 00       	call   80104440 <acquire>
80102cba:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cc1:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102cc8:	00 00 00 
80102ccb:	e8 a0 12 00 00       	call   80103f70 <wakeup>
80102cd0:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cd7:	e8 84 18 00 00       	call   80104560 <release>
80102cdc:	83 c4 10             	add    $0x10,%esp
80102cdf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ce2:	5b                   	pop    %ebx
80102ce3:	5e                   	pop    %esi
80102ce4:	5f                   	pop    %edi
80102ce5:	5d                   	pop    %ebp
80102ce6:	c3                   	ret    
80102ce7:	89 f6                	mov    %esi,%esi
80102ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102cf0:	83 ec 0c             	sub    $0xc,%esp
80102cf3:	68 80 26 11 80       	push   $0x80112680
80102cf8:	e8 73 12 00 00       	call   80103f70 <wakeup>
80102cfd:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d04:	e8 57 18 00 00       	call   80104560 <release>
80102d09:	83 c4 10             	add    $0x10,%esp
80102d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d0f:	5b                   	pop    %ebx
80102d10:	5e                   	pop    %esi
80102d11:	5f                   	pop    %edi
80102d12:	5d                   	pop    %ebp
80102d13:	c3                   	ret    
80102d14:	83 ec 0c             	sub    $0xc,%esp
80102d17:	68 64 75 10 80       	push   $0x80107564
80102d1c:	e8 4f d6 ff ff       	call   80100370 <panic>
80102d21:	eb 0d                	jmp    80102d30 <log_write>
80102d23:	90                   	nop
80102d24:	90                   	nop
80102d25:	90                   	nop
80102d26:	90                   	nop
80102d27:	90                   	nop
80102d28:	90                   	nop
80102d29:	90                   	nop
80102d2a:	90                   	nop
80102d2b:	90                   	nop
80102d2c:	90                   	nop
80102d2d:	90                   	nop
80102d2e:	90                   	nop
80102d2f:	90                   	nop

80102d30 <log_write>:
80102d30:	55                   	push   %ebp
80102d31:	89 e5                	mov    %esp,%ebp
80102d33:	53                   	push   %ebx
80102d34:	83 ec 04             	sub    $0x4,%esp
80102d37:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102d3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d40:	83 fa 1d             	cmp    $0x1d,%edx
80102d43:	0f 8f 97 00 00 00    	jg     80102de0 <log_write+0xb0>
80102d49:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102d4e:	83 e8 01             	sub    $0x1,%eax
80102d51:	39 c2                	cmp    %eax,%edx
80102d53:	0f 8d 87 00 00 00    	jge    80102de0 <log_write+0xb0>
80102d59:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102d5e:	85 c0                	test   %eax,%eax
80102d60:	0f 8e 87 00 00 00    	jle    80102ded <log_write+0xbd>
80102d66:	83 ec 0c             	sub    $0xc,%esp
80102d69:	68 80 26 11 80       	push   $0x80112680
80102d6e:	e8 cd 16 00 00       	call   80104440 <acquire>
80102d73:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102d79:	83 c4 10             	add    $0x10,%esp
80102d7c:	83 fa 00             	cmp    $0x0,%edx
80102d7f:	7e 50                	jle    80102dd1 <log_write+0xa1>
80102d81:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102d84:	31 c0                	xor    %eax,%eax
80102d86:	3b 0d cc 26 11 80    	cmp    0x801126cc,%ecx
80102d8c:	75 0b                	jne    80102d99 <log_write+0x69>
80102d8e:	eb 38                	jmp    80102dc8 <log_write+0x98>
80102d90:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102d97:	74 2f                	je     80102dc8 <log_write+0x98>
80102d99:	83 c0 01             	add    $0x1,%eax
80102d9c:	39 d0                	cmp    %edx,%eax
80102d9e:	75 f0                	jne    80102d90 <log_write+0x60>
80102da0:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
80102da7:	83 c2 01             	add    $0x1,%edx
80102daa:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
80102db0:	83 0b 04             	orl    $0x4,(%ebx)
80102db3:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
80102dba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dbd:	c9                   	leave  
80102dbe:	e9 9d 17 00 00       	jmp    80104560 <release>
80102dc3:	90                   	nop
80102dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102dc8:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102dcf:	eb df                	jmp    80102db0 <log_write+0x80>
80102dd1:	8b 43 08             	mov    0x8(%ebx),%eax
80102dd4:	a3 cc 26 11 80       	mov    %eax,0x801126cc
80102dd9:	75 d5                	jne    80102db0 <log_write+0x80>
80102ddb:	eb ca                	jmp    80102da7 <log_write+0x77>
80102ddd:	8d 76 00             	lea    0x0(%esi),%esi
80102de0:	83 ec 0c             	sub    $0xc,%esp
80102de3:	68 73 75 10 80       	push   $0x80107573
80102de8:	e8 83 d5 ff ff       	call   80100370 <panic>
80102ded:	83 ec 0c             	sub    $0xc,%esp
80102df0:	68 89 75 10 80       	push   $0x80107589
80102df5:	e8 76 d5 ff ff       	call   80100370 <panic>
80102dfa:	66 90                	xchg   %ax,%ax
80102dfc:	66 90                	xchg   %ax,%ax
80102dfe:	66 90                	xchg   %ax,%ax

80102e00 <mpmain>:
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	53                   	push   %ebx
80102e04:	83 ec 04             	sub    $0x4,%esp
80102e07:	e8 64 09 00 00       	call   80103770 <cpuid>
80102e0c:	89 c3                	mov    %eax,%ebx
80102e0e:	e8 5d 09 00 00       	call   80103770 <cpuid>
80102e13:	83 ec 04             	sub    $0x4,%esp
80102e16:	53                   	push   %ebx
80102e17:	50                   	push   %eax
80102e18:	68 a4 75 10 80       	push   $0x801075a4
80102e1d:	e8 3e d8 ff ff       	call   80100660 <cprintf>
80102e22:	e8 a9 2a 00 00       	call   801058d0 <idtinit>
80102e27:	e8 c4 08 00 00       	call   801036f0 <mycpu>
80102e2c:	89 c2                	mov    %eax,%edx
80102e2e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e33:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
80102e3a:	e8 11 0c 00 00       	call   80103a50 <scheduler>
80102e3f:	90                   	nop

80102e40 <mpenter>:
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	83 ec 08             	sub    $0x8,%esp
80102e46:	e8 a5 3b 00 00       	call   801069f0 <switchkvm>
80102e4b:	e8 a0 3a 00 00       	call   801068f0 <seginit>
80102e50:	e8 9b f7 ff ff       	call   801025f0 <lapicinit>
80102e55:	e8 a6 ff ff ff       	call   80102e00 <mpmain>
80102e5a:	66 90                	xchg   %ax,%ax
80102e5c:	66 90                	xchg   %ax,%ax
80102e5e:	66 90                	xchg   %ax,%ax

80102e60 <main>:
80102e60:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e64:	83 e4 f0             	and    $0xfffffff0,%esp
80102e67:	ff 71 fc             	pushl  -0x4(%ecx)
80102e6a:	55                   	push   %ebp
80102e6b:	89 e5                	mov    %esp,%ebp
80102e6d:	53                   	push   %ebx
80102e6e:	51                   	push   %ecx
80102e6f:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102e74:	83 ec 08             	sub    $0x8,%esp
80102e77:	68 00 00 40 80       	push   $0x80400000
80102e7c:	68 a8 55 11 80       	push   $0x801155a8
80102e81:	e8 3a f5 ff ff       	call   801023c0 <kinit1>
80102e86:	e8 05 40 00 00       	call   80106e90 <kvmalloc>
80102e8b:	e8 70 01 00 00       	call   80103000 <mpinit>
80102e90:	e8 5b f7 ff ff       	call   801025f0 <lapicinit>
80102e95:	e8 56 3a 00 00       	call   801068f0 <seginit>
80102e9a:	e8 31 03 00 00       	call   801031d0 <picinit>
80102e9f:	e8 4c f3 ff ff       	call   801021f0 <ioapicinit>
80102ea4:	e8 f7 da ff ff       	call   801009a0 <consoleinit>
80102ea9:	e8 12 2d 00 00       	call   80105bc0 <uartinit>
80102eae:	e8 1d 08 00 00       	call   801036d0 <pinit>
80102eb3:	e8 78 29 00 00       	call   80105830 <tvinit>
80102eb8:	e8 83 d1 ff ff       	call   80100040 <binit>
80102ebd:	e8 8e de ff ff       	call   80100d50 <fileinit>
80102ec2:	e8 09 f1 ff ff       	call   80101fd0 <ideinit>
80102ec7:	83 c4 0c             	add    $0xc,%esp
80102eca:	68 8a 00 00 00       	push   $0x8a
80102ecf:	68 8c a4 10 80       	push   $0x8010a48c
80102ed4:	68 00 70 00 80       	push   $0x80007000
80102ed9:	e8 82 17 00 00       	call   80104660 <memmove>
80102ede:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ee5:	00 00 00 
80102ee8:	83 c4 10             	add    $0x10,%esp
80102eeb:	05 80 27 11 80       	add    $0x80112780,%eax
80102ef0:	39 d8                	cmp    %ebx,%eax
80102ef2:	76 6f                	jbe    80102f63 <main+0x103>
80102ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ef8:	e8 f3 07 00 00       	call   801036f0 <mycpu>
80102efd:	39 d8                	cmp    %ebx,%eax
80102eff:	74 49                	je     80102f4a <main+0xea>
80102f01:	e8 8a f5 ff ff       	call   80102490 <kalloc>
80102f06:	05 00 10 00 00       	add    $0x1000,%eax
80102f0b:	c7 05 f8 6f 00 80 40 	movl   $0x80102e40,0x80006ff8
80102f12:	2e 10 80 
80102f15:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f1c:	90 10 00 
80102f1f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
80102f24:	0f b6 03             	movzbl (%ebx),%eax
80102f27:	83 ec 08             	sub    $0x8,%esp
80102f2a:	68 00 70 00 00       	push   $0x7000
80102f2f:	50                   	push   %eax
80102f30:	e8 0b f8 ff ff       	call   80102740 <lapicstartap>
80102f35:	83 c4 10             	add    $0x10,%esp
80102f38:	90                   	nop
80102f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f40:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f46:	85 c0                	test   %eax,%eax
80102f48:	74 f6                	je     80102f40 <main+0xe0>
80102f4a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f51:	00 00 00 
80102f54:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f5a:	05 80 27 11 80       	add    $0x80112780,%eax
80102f5f:	39 c3                	cmp    %eax,%ebx
80102f61:	72 95                	jb     80102ef8 <main+0x98>
80102f63:	83 ec 08             	sub    $0x8,%esp
80102f66:	68 00 00 00 8e       	push   $0x8e000000
80102f6b:	68 00 00 40 80       	push   $0x80400000
80102f70:	e8 bb f4 ff ff       	call   80102430 <kinit2>
80102f75:	e8 46 08 00 00       	call   801037c0 <userinit>
80102f7a:	e8 81 fe ff ff       	call   80102e00 <mpmain>
80102f7f:	90                   	nop

80102f80 <mpsearch1>:
80102f80:	55                   	push   %ebp
80102f81:	89 e5                	mov    %esp,%ebp
80102f83:	57                   	push   %edi
80102f84:	56                   	push   %esi
80102f85:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
80102f8b:	53                   	push   %ebx
80102f8c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
80102f8f:	83 ec 0c             	sub    $0xc,%esp
80102f92:	39 de                	cmp    %ebx,%esi
80102f94:	73 48                	jae    80102fde <mpsearch1+0x5e>
80102f96:	8d 76 00             	lea    0x0(%esi),%esi
80102f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102fa0:	83 ec 04             	sub    $0x4,%esp
80102fa3:	8d 7e 10             	lea    0x10(%esi),%edi
80102fa6:	6a 04                	push   $0x4
80102fa8:	68 b8 75 10 80       	push   $0x801075b8
80102fad:	56                   	push   %esi
80102fae:	e8 4d 16 00 00       	call   80104600 <memcmp>
80102fb3:	83 c4 10             	add    $0x10,%esp
80102fb6:	85 c0                	test   %eax,%eax
80102fb8:	75 1e                	jne    80102fd8 <mpsearch1+0x58>
80102fba:	8d 7e 10             	lea    0x10(%esi),%edi
80102fbd:	89 f2                	mov    %esi,%edx
80102fbf:	31 c9                	xor    %ecx,%ecx
80102fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fc8:	0f b6 02             	movzbl (%edx),%eax
80102fcb:	83 c2 01             	add    $0x1,%edx
80102fce:	01 c1                	add    %eax,%ecx
80102fd0:	39 fa                	cmp    %edi,%edx
80102fd2:	75 f4                	jne    80102fc8 <mpsearch1+0x48>
80102fd4:	84 c9                	test   %cl,%cl
80102fd6:	74 10                	je     80102fe8 <mpsearch1+0x68>
80102fd8:	39 fb                	cmp    %edi,%ebx
80102fda:	89 fe                	mov    %edi,%esi
80102fdc:	77 c2                	ja     80102fa0 <mpsearch1+0x20>
80102fde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fe1:	31 c0                	xor    %eax,%eax
80102fe3:	5b                   	pop    %ebx
80102fe4:	5e                   	pop    %esi
80102fe5:	5f                   	pop    %edi
80102fe6:	5d                   	pop    %ebp
80102fe7:	c3                   	ret    
80102fe8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102feb:	89 f0                	mov    %esi,%eax
80102fed:	5b                   	pop    %ebx
80102fee:	5e                   	pop    %esi
80102fef:	5f                   	pop    %edi
80102ff0:	5d                   	pop    %ebp
80102ff1:	c3                   	ret    
80102ff2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103000 <mpinit>:
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	57                   	push   %edi
80103004:	56                   	push   %esi
80103005:	53                   	push   %ebx
80103006:	83 ec 1c             	sub    $0x1c,%esp
80103009:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103010:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103017:	c1 e0 08             	shl    $0x8,%eax
8010301a:	09 d0                	or     %edx,%eax
8010301c:	c1 e0 04             	shl    $0x4,%eax
8010301f:	85 c0                	test   %eax,%eax
80103021:	75 1b                	jne    8010303e <mpinit+0x3e>
80103023:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010302a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103031:	c1 e0 08             	shl    $0x8,%eax
80103034:	09 d0                	or     %edx,%eax
80103036:	c1 e0 0a             	shl    $0xa,%eax
80103039:	2d 00 04 00 00       	sub    $0x400,%eax
8010303e:	ba 00 04 00 00       	mov    $0x400,%edx
80103043:	e8 38 ff ff ff       	call   80102f80 <mpsearch1>
80103048:	85 c0                	test   %eax,%eax
8010304a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010304d:	0f 84 37 01 00 00    	je     8010318a <mpinit+0x18a>
80103053:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103056:	8b 58 04             	mov    0x4(%eax),%ebx
80103059:	85 db                	test   %ebx,%ebx
8010305b:	0f 84 43 01 00 00    	je     801031a4 <mpinit+0x1a4>
80103061:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
80103067:	83 ec 04             	sub    $0x4,%esp
8010306a:	6a 04                	push   $0x4
8010306c:	68 bd 75 10 80       	push   $0x801075bd
80103071:	56                   	push   %esi
80103072:	e8 89 15 00 00       	call   80104600 <memcmp>
80103077:	83 c4 10             	add    $0x10,%esp
8010307a:	85 c0                	test   %eax,%eax
8010307c:	0f 85 22 01 00 00    	jne    801031a4 <mpinit+0x1a4>
80103082:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103089:	3c 01                	cmp    $0x1,%al
8010308b:	74 08                	je     80103095 <mpinit+0x95>
8010308d:	3c 04                	cmp    $0x4,%al
8010308f:	0f 85 0f 01 00 00    	jne    801031a4 <mpinit+0x1a4>
80103095:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
8010309c:	85 ff                	test   %edi,%edi
8010309e:	74 21                	je     801030c1 <mpinit+0xc1>
801030a0:	31 d2                	xor    %edx,%edx
801030a2:	31 c0                	xor    %eax,%eax
801030a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030a8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801030af:	80 
801030b0:	83 c0 01             	add    $0x1,%eax
801030b3:	01 ca                	add    %ecx,%edx
801030b5:	39 c7                	cmp    %eax,%edi
801030b7:	75 ef                	jne    801030a8 <mpinit+0xa8>
801030b9:	84 d2                	test   %dl,%dl
801030bb:	0f 85 e3 00 00 00    	jne    801031a4 <mpinit+0x1a4>
801030c1:	85 f6                	test   %esi,%esi
801030c3:	0f 84 db 00 00 00    	je     801031a4 <mpinit+0x1a4>
801030c9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801030cf:	a3 7c 26 11 80       	mov    %eax,0x8011267c
801030d4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801030db:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801030e1:	bb 01 00 00 00       	mov    $0x1,%ebx
801030e6:	01 d6                	add    %edx,%esi
801030e8:	90                   	nop
801030e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030f0:	39 c6                	cmp    %eax,%esi
801030f2:	76 23                	jbe    80103117 <mpinit+0x117>
801030f4:	0f b6 10             	movzbl (%eax),%edx
801030f7:	80 fa 04             	cmp    $0x4,%dl
801030fa:	0f 87 c0 00 00 00    	ja     801031c0 <mpinit+0x1c0>
80103100:	ff 24 95 fc 75 10 80 	jmp    *-0x7fef8a04(,%edx,4)
80103107:	89 f6                	mov    %esi,%esi
80103109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103110:	83 c0 08             	add    $0x8,%eax
80103113:	39 c6                	cmp    %eax,%esi
80103115:	77 dd                	ja     801030f4 <mpinit+0xf4>
80103117:	85 db                	test   %ebx,%ebx
80103119:	0f 84 92 00 00 00    	je     801031b1 <mpinit+0x1b1>
8010311f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103122:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103126:	74 15                	je     8010313d <mpinit+0x13d>
80103128:	ba 22 00 00 00       	mov    $0x22,%edx
8010312d:	b8 70 00 00 00       	mov    $0x70,%eax
80103132:	ee                   	out    %al,(%dx)
80103133:	ba 23 00 00 00       	mov    $0x23,%edx
80103138:	ec                   	in     (%dx),%al
80103139:	83 c8 01             	or     $0x1,%eax
8010313c:	ee                   	out    %al,(%dx)
8010313d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103140:	5b                   	pop    %ebx
80103141:	5e                   	pop    %esi
80103142:	5f                   	pop    %edi
80103143:	5d                   	pop    %ebp
80103144:	c3                   	ret    
80103145:	8d 76 00             	lea    0x0(%esi),%esi
80103148:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010314e:	83 f9 07             	cmp    $0x7,%ecx
80103151:	7f 19                	jg     8010316c <mpinit+0x16c>
80103153:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103157:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
8010315d:	83 c1 01             	add    $0x1,%ecx
80103160:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
80103166:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
8010316c:	83 c0 14             	add    $0x14,%eax
8010316f:	e9 7c ff ff ff       	jmp    801030f0 <mpinit+0xf0>
80103174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103178:	0f b6 50 01          	movzbl 0x1(%eax),%edx
8010317c:	83 c0 08             	add    $0x8,%eax
8010317f:	88 15 60 27 11 80    	mov    %dl,0x80112760
80103185:	e9 66 ff ff ff       	jmp    801030f0 <mpinit+0xf0>
8010318a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010318f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103194:	e8 e7 fd ff ff       	call   80102f80 <mpsearch1>
80103199:	85 c0                	test   %eax,%eax
8010319b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010319e:	0f 85 af fe ff ff    	jne    80103053 <mpinit+0x53>
801031a4:	83 ec 0c             	sub    $0xc,%esp
801031a7:	68 c2 75 10 80       	push   $0x801075c2
801031ac:	e8 bf d1 ff ff       	call   80100370 <panic>
801031b1:	83 ec 0c             	sub    $0xc,%esp
801031b4:	68 dc 75 10 80       	push   $0x801075dc
801031b9:	e8 b2 d1 ff ff       	call   80100370 <panic>
801031be:	66 90                	xchg   %ax,%ax
801031c0:	31 db                	xor    %ebx,%ebx
801031c2:	e9 30 ff ff ff       	jmp    801030f7 <mpinit+0xf7>
801031c7:	66 90                	xchg   %ax,%ax
801031c9:	66 90                	xchg   %ax,%ax
801031cb:	66 90                	xchg   %ax,%ax
801031cd:	66 90                	xchg   %ax,%ax
801031cf:	90                   	nop

801031d0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801031d0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031d1:	ba 21 00 00 00       	mov    $0x21,%edx
801031d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801031db:	89 e5                	mov    %esp,%ebp
801031dd:	ee                   	out    %al,(%dx)
801031de:	ba a1 00 00 00       	mov    $0xa1,%edx
801031e3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801031e4:	5d                   	pop    %ebp
801031e5:	c3                   	ret    
801031e6:	66 90                	xchg   %ax,%ax
801031e8:	66 90                	xchg   %ax,%ax
801031ea:	66 90                	xchg   %ax,%ax
801031ec:	66 90                	xchg   %ax,%ax
801031ee:	66 90                	xchg   %ax,%ax

801031f0 <pipealloc>:
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	57                   	push   %edi
801031f4:	56                   	push   %esi
801031f5:	53                   	push   %ebx
801031f6:	83 ec 0c             	sub    $0xc,%esp
801031f9:	8b 75 08             	mov    0x8(%ebp),%esi
801031fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801031ff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103205:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010320b:	e8 60 db ff ff       	call   80100d70 <filealloc>
80103210:	85 c0                	test   %eax,%eax
80103212:	89 06                	mov    %eax,(%esi)
80103214:	0f 84 a8 00 00 00    	je     801032c2 <pipealloc+0xd2>
8010321a:	e8 51 db ff ff       	call   80100d70 <filealloc>
8010321f:	85 c0                	test   %eax,%eax
80103221:	89 03                	mov    %eax,(%ebx)
80103223:	0f 84 87 00 00 00    	je     801032b0 <pipealloc+0xc0>
80103229:	e8 62 f2 ff ff       	call   80102490 <kalloc>
8010322e:	85 c0                	test   %eax,%eax
80103230:	89 c7                	mov    %eax,%edi
80103232:	0f 84 b0 00 00 00    	je     801032e8 <pipealloc+0xf8>
80103238:	83 ec 08             	sub    $0x8,%esp
8010323b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103242:	00 00 00 
80103245:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010324c:	00 00 00 
8010324f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103256:	00 00 00 
80103259:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103260:	00 00 00 
80103263:	68 10 76 10 80       	push   $0x80107610
80103268:	50                   	push   %eax
80103269:	e8 d2 10 00 00       	call   80104340 <initlock>
8010326e:	8b 06                	mov    (%esi),%eax
80103270:	83 c4 10             	add    $0x10,%esp
80103273:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103279:	8b 06                	mov    (%esi),%eax
8010327b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
8010327f:	8b 06                	mov    (%esi),%eax
80103281:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103285:	8b 06                	mov    (%esi),%eax
80103287:	89 78 0c             	mov    %edi,0xc(%eax)
8010328a:	8b 03                	mov    (%ebx),%eax
8010328c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103292:	8b 03                	mov    (%ebx),%eax
80103294:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103298:	8b 03                	mov    (%ebx),%eax
8010329a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
8010329e:	8b 03                	mov    (%ebx),%eax
801032a0:	89 78 0c             	mov    %edi,0xc(%eax)
801032a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032a6:	31 c0                	xor    %eax,%eax
801032a8:	5b                   	pop    %ebx
801032a9:	5e                   	pop    %esi
801032aa:	5f                   	pop    %edi
801032ab:	5d                   	pop    %ebp
801032ac:	c3                   	ret    
801032ad:	8d 76 00             	lea    0x0(%esi),%esi
801032b0:	8b 06                	mov    (%esi),%eax
801032b2:	85 c0                	test   %eax,%eax
801032b4:	74 1e                	je     801032d4 <pipealloc+0xe4>
801032b6:	83 ec 0c             	sub    $0xc,%esp
801032b9:	50                   	push   %eax
801032ba:	e8 71 db ff ff       	call   80100e30 <fileclose>
801032bf:	83 c4 10             	add    $0x10,%esp
801032c2:	8b 03                	mov    (%ebx),%eax
801032c4:	85 c0                	test   %eax,%eax
801032c6:	74 0c                	je     801032d4 <pipealloc+0xe4>
801032c8:	83 ec 0c             	sub    $0xc,%esp
801032cb:	50                   	push   %eax
801032cc:	e8 5f db ff ff       	call   80100e30 <fileclose>
801032d1:	83 c4 10             	add    $0x10,%esp
801032d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032dc:	5b                   	pop    %ebx
801032dd:	5e                   	pop    %esi
801032de:	5f                   	pop    %edi
801032df:	5d                   	pop    %ebp
801032e0:	c3                   	ret    
801032e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032e8:	8b 06                	mov    (%esi),%eax
801032ea:	85 c0                	test   %eax,%eax
801032ec:	75 c8                	jne    801032b6 <pipealloc+0xc6>
801032ee:	eb d2                	jmp    801032c2 <pipealloc+0xd2>

801032f0 <pipeclose>:
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	56                   	push   %esi
801032f4:	53                   	push   %ebx
801032f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801032f8:	8b 75 0c             	mov    0xc(%ebp),%esi
801032fb:	83 ec 0c             	sub    $0xc,%esp
801032fe:	53                   	push   %ebx
801032ff:	e8 3c 11 00 00       	call   80104440 <acquire>
80103304:	83 c4 10             	add    $0x10,%esp
80103307:	85 f6                	test   %esi,%esi
80103309:	74 45                	je     80103350 <pipeclose+0x60>
8010330b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103311:	83 ec 0c             	sub    $0xc,%esp
80103314:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010331b:	00 00 00 
8010331e:	50                   	push   %eax
8010331f:	e8 4c 0c 00 00       	call   80103f70 <wakeup>
80103324:	83 c4 10             	add    $0x10,%esp
80103327:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010332d:	85 d2                	test   %edx,%edx
8010332f:	75 0a                	jne    8010333b <pipeclose+0x4b>
80103331:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103337:	85 c0                	test   %eax,%eax
80103339:	74 35                	je     80103370 <pipeclose+0x80>
8010333b:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010333e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103341:	5b                   	pop    %ebx
80103342:	5e                   	pop    %esi
80103343:	5d                   	pop    %ebp
80103344:	e9 17 12 00 00       	jmp    80104560 <release>
80103349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103350:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103356:	83 ec 0c             	sub    $0xc,%esp
80103359:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103360:	00 00 00 
80103363:	50                   	push   %eax
80103364:	e8 07 0c 00 00       	call   80103f70 <wakeup>
80103369:	83 c4 10             	add    $0x10,%esp
8010336c:	eb b9                	jmp    80103327 <pipeclose+0x37>
8010336e:	66 90                	xchg   %ax,%ax
80103370:	83 ec 0c             	sub    $0xc,%esp
80103373:	53                   	push   %ebx
80103374:	e8 e7 11 00 00       	call   80104560 <release>
80103379:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010337c:	83 c4 10             	add    $0x10,%esp
8010337f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103382:	5b                   	pop    %ebx
80103383:	5e                   	pop    %esi
80103384:	5d                   	pop    %ebp
80103385:	e9 56 ef ff ff       	jmp    801022e0 <kfree>
8010338a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103390 <pipewrite>:
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	57                   	push   %edi
80103394:	56                   	push   %esi
80103395:	53                   	push   %ebx
80103396:	83 ec 28             	sub    $0x28,%esp
80103399:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010339c:	53                   	push   %ebx
8010339d:	e8 9e 10 00 00       	call   80104440 <acquire>
801033a2:	8b 45 10             	mov    0x10(%ebp),%eax
801033a5:	83 c4 10             	add    $0x10,%esp
801033a8:	85 c0                	test   %eax,%eax
801033aa:	0f 8e b9 00 00 00    	jle    80103469 <pipewrite+0xd9>
801033b0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801033b3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801033b9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801033bf:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801033c5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801033c8:	03 4d 10             	add    0x10(%ebp),%ecx
801033cb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801033ce:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801033d4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801033da:	39 d0                	cmp    %edx,%eax
801033dc:	74 38                	je     80103416 <pipewrite+0x86>
801033de:	eb 59                	jmp    80103439 <pipewrite+0xa9>
801033e0:	e8 ab 03 00 00       	call   80103790 <myproc>
801033e5:	8b 48 24             	mov    0x24(%eax),%ecx
801033e8:	85 c9                	test   %ecx,%ecx
801033ea:	75 34                	jne    80103420 <pipewrite+0x90>
801033ec:	83 ec 0c             	sub    $0xc,%esp
801033ef:	57                   	push   %edi
801033f0:	e8 7b 0b 00 00       	call   80103f70 <wakeup>
801033f5:	58                   	pop    %eax
801033f6:	5a                   	pop    %edx
801033f7:	53                   	push   %ebx
801033f8:	56                   	push   %esi
801033f9:	e8 c2 09 00 00       	call   80103dc0 <sleep>
801033fe:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103404:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010340a:	83 c4 10             	add    $0x10,%esp
8010340d:	05 00 02 00 00       	add    $0x200,%eax
80103412:	39 c2                	cmp    %eax,%edx
80103414:	75 2a                	jne    80103440 <pipewrite+0xb0>
80103416:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010341c:	85 c0                	test   %eax,%eax
8010341e:	75 c0                	jne    801033e0 <pipewrite+0x50>
80103420:	83 ec 0c             	sub    $0xc,%esp
80103423:	53                   	push   %ebx
80103424:	e8 37 11 00 00       	call   80104560 <release>
80103429:	83 c4 10             	add    $0x10,%esp
8010342c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103431:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103434:	5b                   	pop    %ebx
80103435:	5e                   	pop    %esi
80103436:	5f                   	pop    %edi
80103437:	5d                   	pop    %ebp
80103438:	c3                   	ret    
80103439:	89 c2                	mov    %eax,%edx
8010343b:	90                   	nop
8010343c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103440:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103443:	8d 42 01             	lea    0x1(%edx),%eax
80103446:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010344a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103450:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103456:	0f b6 09             	movzbl (%ecx),%ecx
80103459:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010345d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103460:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103463:	0f 85 65 ff ff ff    	jne    801033ce <pipewrite+0x3e>
80103469:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010346f:	83 ec 0c             	sub    $0xc,%esp
80103472:	50                   	push   %eax
80103473:	e8 f8 0a 00 00       	call   80103f70 <wakeup>
80103478:	89 1c 24             	mov    %ebx,(%esp)
8010347b:	e8 e0 10 00 00       	call   80104560 <release>
80103480:	83 c4 10             	add    $0x10,%esp
80103483:	8b 45 10             	mov    0x10(%ebp),%eax
80103486:	eb a9                	jmp    80103431 <pipewrite+0xa1>
80103488:	90                   	nop
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103490 <piperead>:
80103490:	55                   	push   %ebp
80103491:	89 e5                	mov    %esp,%ebp
80103493:	57                   	push   %edi
80103494:	56                   	push   %esi
80103495:	53                   	push   %ebx
80103496:	83 ec 18             	sub    $0x18,%esp
80103499:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010349c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010349f:	53                   	push   %ebx
801034a0:	e8 9b 0f 00 00       	call   80104440 <acquire>
801034a5:	83 c4 10             	add    $0x10,%esp
801034a8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801034ae:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801034b4:	75 6a                	jne    80103520 <piperead+0x90>
801034b6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801034bc:	85 f6                	test   %esi,%esi
801034be:	0f 84 cc 00 00 00    	je     80103590 <piperead+0x100>
801034c4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801034ca:	eb 2d                	jmp    801034f9 <piperead+0x69>
801034cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034d0:	83 ec 08             	sub    $0x8,%esp
801034d3:	53                   	push   %ebx
801034d4:	56                   	push   %esi
801034d5:	e8 e6 08 00 00       	call   80103dc0 <sleep>
801034da:	83 c4 10             	add    $0x10,%esp
801034dd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801034e3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801034e9:	75 35                	jne    80103520 <piperead+0x90>
801034eb:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801034f1:	85 d2                	test   %edx,%edx
801034f3:	0f 84 97 00 00 00    	je     80103590 <piperead+0x100>
801034f9:	e8 92 02 00 00       	call   80103790 <myproc>
801034fe:	8b 48 24             	mov    0x24(%eax),%ecx
80103501:	85 c9                	test   %ecx,%ecx
80103503:	74 cb                	je     801034d0 <piperead+0x40>
80103505:	83 ec 0c             	sub    $0xc,%esp
80103508:	53                   	push   %ebx
80103509:	e8 52 10 00 00       	call   80104560 <release>
8010350e:	83 c4 10             	add    $0x10,%esp
80103511:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103514:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103519:	5b                   	pop    %ebx
8010351a:	5e                   	pop    %esi
8010351b:	5f                   	pop    %edi
8010351c:	5d                   	pop    %ebp
8010351d:	c3                   	ret    
8010351e:	66 90                	xchg   %ax,%ax
80103520:	8b 45 10             	mov    0x10(%ebp),%eax
80103523:	85 c0                	test   %eax,%eax
80103525:	7e 69                	jle    80103590 <piperead+0x100>
80103527:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010352d:	31 c9                	xor    %ecx,%ecx
8010352f:	eb 15                	jmp    80103546 <piperead+0xb6>
80103531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103538:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010353e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103544:	74 5a                	je     801035a0 <piperead+0x110>
80103546:	8d 70 01             	lea    0x1(%eax),%esi
80103549:	25 ff 01 00 00       	and    $0x1ff,%eax
8010354e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103554:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103559:	88 04 0f             	mov    %al,(%edi,%ecx,1)
8010355c:	83 c1 01             	add    $0x1,%ecx
8010355f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103562:	75 d4                	jne    80103538 <piperead+0xa8>
80103564:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010356a:	83 ec 0c             	sub    $0xc,%esp
8010356d:	50                   	push   %eax
8010356e:	e8 fd 09 00 00       	call   80103f70 <wakeup>
80103573:	89 1c 24             	mov    %ebx,(%esp)
80103576:	e8 e5 0f 00 00       	call   80104560 <release>
8010357b:	8b 45 10             	mov    0x10(%ebp),%eax
8010357e:	83 c4 10             	add    $0x10,%esp
80103581:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103584:	5b                   	pop    %ebx
80103585:	5e                   	pop    %esi
80103586:	5f                   	pop    %edi
80103587:	5d                   	pop    %ebp
80103588:	c3                   	ret    
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103590:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103597:	eb cb                	jmp    80103564 <piperead+0xd4>
80103599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035a0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801035a3:	eb bf                	jmp    80103564 <piperead+0xd4>
801035a5:	66 90                	xchg   %ax,%ax
801035a7:	66 90                	xchg   %ax,%ax
801035a9:	66 90                	xchg   %ax,%ax
801035ab:	66 90                	xchg   %ax,%ax
801035ad:	66 90                	xchg   %ax,%ax
801035af:	90                   	nop

801035b0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035b4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035b9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801035bc:	68 20 2d 11 80       	push   $0x80112d20
801035c1:	e8 7a 0e 00 00       	call   80104440 <acquire>
801035c6:	83 c4 10             	add    $0x10,%esp
801035c9:	eb 14                	jmp    801035df <allocproc+0x2f>
801035cb:	90                   	nop
801035cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035d0:	83 eb 80             	sub    $0xffffff80,%ebx
801035d3:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
801035d9:	0f 84 81 00 00 00    	je     80103660 <allocproc+0xb0>
    if(p->state == UNUSED)
801035df:	8b 43 0c             	mov    0xc(%ebx),%eax
801035e2:	85 c0                	test   %eax,%eax
801035e4:	75 ea                	jne    801035d0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035e6:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  p->priority=5;
  release(&ptable.lock);
801035eb:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801035ee:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
  p->priority=5;
  release(&ptable.lock);
801035f5:	68 20 2d 11 80       	push   $0x80112d20
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->priority=5;
801035fa:	c7 43 7c 05 00 00 00 	movl   $0x5,0x7c(%ebx)
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103601:	8d 50 01             	lea    0x1(%eax),%edx
80103604:	89 43 10             	mov    %eax,0x10(%ebx)
80103607:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  p->priority=5;
  release(&ptable.lock);
8010360d:	e8 4e 0f 00 00       	call   80104560 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103612:	e8 79 ee ff ff       	call   80102490 <kalloc>
80103617:	83 c4 10             	add    $0x10,%esp
8010361a:	85 c0                	test   %eax,%eax
8010361c:	89 43 08             	mov    %eax,0x8(%ebx)
8010361f:	74 56                	je     80103677 <allocproc+0xc7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103621:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103627:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010362a:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010362f:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103632:	c7 40 14 1f 58 10 80 	movl   $0x8010581f,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103639:	6a 14                	push   $0x14
8010363b:	6a 00                	push   $0x0
8010363d:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
8010363e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103641:	e8 6a 0f 00 00       	call   801045b0 <memset>
  p->context->eip = (uint)forkret;
80103646:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103649:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
8010364c:	c7 40 10 80 36 10 80 	movl   $0x80103680,0x10(%eax)

  return p;
80103653:	89 d8                	mov    %ebx,%eax
}
80103655:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103658:	c9                   	leave  
80103659:	c3                   	ret    
8010365a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103660:	83 ec 0c             	sub    $0xc,%esp
80103663:	68 20 2d 11 80       	push   $0x80112d20
80103668:	e8 f3 0e 00 00       	call   80104560 <release>
  return 0;
8010366d:	83 c4 10             	add    $0x10,%esp
80103670:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103672:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103675:	c9                   	leave  
80103676:	c3                   	ret    
  p->priority=5;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103677:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010367e:	eb d5                	jmp    80103655 <allocproc+0xa5>

80103680 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103686:	68 20 2d 11 80       	push   $0x80112d20
8010368b:	e8 d0 0e 00 00       	call   80104560 <release>

  if (first) {
80103690:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103695:	83 c4 10             	add    $0x10,%esp
80103698:	85 c0                	test   %eax,%eax
8010369a:	75 04                	jne    801036a0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010369c:	c9                   	leave  
8010369d:	c3                   	ret    
8010369e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801036a0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801036a3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801036aa:	00 00 00 
    iinit(ROOTDEV);
801036ad:	6a 01                	push   $0x1
801036af:	e8 bc dd ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
801036b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801036bb:	e8 f0 f3 ff ff       	call   80102ab0 <initlog>
801036c0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036c3:	c9                   	leave  
801036c4:	c3                   	ret    
801036c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036d0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801036d6:	68 15 76 10 80       	push   $0x80107615
801036db:	68 20 2d 11 80       	push   $0x80112d20
801036e0:	e8 5b 0c 00 00       	call   80104340 <initlock>
}
801036e5:	83 c4 10             	add    $0x10,%esp
801036e8:	c9                   	leave  
801036e9:	c3                   	ret    
801036ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801036f0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	56                   	push   %esi
801036f4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801036f5:	9c                   	pushf  
801036f6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801036f7:	f6 c4 02             	test   $0x2,%ah
801036fa:	75 5b                	jne    80103757 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801036fc:	e8 ef ef ff ff       	call   801026f0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103701:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103707:	85 f6                	test   %esi,%esi
80103709:	7e 3f                	jle    8010374a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010370b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103712:	39 d0                	cmp    %edx,%eax
80103714:	74 30                	je     80103746 <mycpu+0x56>
80103716:	b9 30 28 11 80       	mov    $0x80112830,%ecx
8010371b:	31 d2                	xor    %edx,%edx
8010371d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103720:	83 c2 01             	add    $0x1,%edx
80103723:	39 f2                	cmp    %esi,%edx
80103725:	74 23                	je     8010374a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103727:	0f b6 19             	movzbl (%ecx),%ebx
8010372a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103730:	39 d8                	cmp    %ebx,%eax
80103732:	75 ec                	jne    80103720 <mycpu+0x30>
      return &cpus[i];
80103734:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010373a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010373d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010373e:	05 80 27 11 80       	add    $0x80112780,%eax
  }
  panic("unknown apicid\n");
}
80103743:	5e                   	pop    %esi
80103744:	5d                   	pop    %ebp
80103745:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103746:	31 d2                	xor    %edx,%edx
80103748:	eb ea                	jmp    80103734 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010374a:	83 ec 0c             	sub    $0xc,%esp
8010374d:	68 1c 76 10 80       	push   $0x8010761c
80103752:	e8 19 cc ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103757:	83 ec 0c             	sub    $0xc,%esp
8010375a:	68 54 77 10 80       	push   $0x80107754
8010375f:	e8 0c cc ff ff       	call   80100370 <panic>
80103764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010376a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103770 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103776:	e8 75 ff ff ff       	call   801036f0 <mycpu>
8010377b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103780:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103781:	c1 f8 04             	sar    $0x4,%eax
80103784:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010378a:	c3                   	ret    
8010378b:	90                   	nop
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103790 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	53                   	push   %ebx
80103794:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103797:	e8 64 0c 00 00       	call   80104400 <pushcli>
  c = mycpu();
8010379c:	e8 4f ff ff ff       	call   801036f0 <mycpu>
  p = c->proc;
801037a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037a7:	e8 44 0d 00 00       	call   801044f0 <popcli>
  return p;
}
801037ac:	83 c4 04             	add    $0x4,%esp
801037af:	89 d8                	mov    %ebx,%eax
801037b1:	5b                   	pop    %ebx
801037b2:	5d                   	pop    %ebp
801037b3:	c3                   	ret    
801037b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037c0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
801037c4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801037c7:	e8 e4 fd ff ff       	call   801035b0 <allocproc>
801037cc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801037ce:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801037d3:	e8 38 36 00 00       	call   80106e10 <setupkvm>
801037d8:	85 c0                	test   %eax,%eax
801037da:	89 43 04             	mov    %eax,0x4(%ebx)
801037dd:	0f 84 bd 00 00 00    	je     801038a0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801037e3:	83 ec 04             	sub    $0x4,%esp
801037e6:	68 2c 00 00 00       	push   $0x2c
801037eb:	68 60 a4 10 80       	push   $0x8010a460
801037f0:	50                   	push   %eax
801037f1:	e8 2a 33 00 00       	call   80106b20 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801037f6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801037f9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801037ff:	6a 4c                	push   $0x4c
80103801:	6a 00                	push   $0x0
80103803:	ff 73 18             	pushl  0x18(%ebx)
80103806:	e8 a5 0d 00 00       	call   801045b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010380b:	8b 43 18             	mov    0x18(%ebx),%eax
8010380e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103813:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103818:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010381b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010381f:	8b 43 18             	mov    0x18(%ebx),%eax
80103822:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103826:	8b 43 18             	mov    0x18(%ebx),%eax
80103829:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010382d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103831:	8b 43 18             	mov    0x18(%ebx),%eax
80103834:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103838:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010383c:	8b 43 18             	mov    0x18(%ebx),%eax
8010383f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103846:	8b 43 18             	mov    0x18(%ebx),%eax
80103849:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103850:	8b 43 18             	mov    0x18(%ebx),%eax
80103853:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010385a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010385d:	6a 10                	push   $0x10
8010385f:	68 45 76 10 80       	push   $0x80107645
80103864:	50                   	push   %eax
80103865:	e8 46 0f 00 00       	call   801047b0 <safestrcpy>
  p->cwd = namei("/");
8010386a:	c7 04 24 4e 76 10 80 	movl   $0x8010764e,(%esp)
80103871:	e8 4a e6 ff ff       	call   80101ec0 <namei>
80103876:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103879:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103880:	e8 bb 0b 00 00       	call   80104440 <acquire>

  p->state = RUNNABLE;
80103885:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
8010388c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103893:	e8 c8 0c 00 00       	call   80104560 <release>
}
80103898:	83 c4 10             	add    $0x10,%esp
8010389b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010389e:	c9                   	leave  
8010389f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801038a0:	83 ec 0c             	sub    $0xc,%esp
801038a3:	68 2c 76 10 80       	push   $0x8010762c
801038a8:	e8 c3 ca ff ff       	call   80100370 <panic>
801038ad:	8d 76 00             	lea    0x0(%esi),%esi

801038b0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	56                   	push   %esi
801038b4:	53                   	push   %ebx
801038b5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801038b8:	e8 43 0b 00 00       	call   80104400 <pushcli>
  c = mycpu();
801038bd:	e8 2e fe ff ff       	call   801036f0 <mycpu>
  p = c->proc;
801038c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038c8:	e8 23 0c 00 00       	call   801044f0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
801038cd:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
801038d0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801038d2:	7e 34                	jle    80103908 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801038d4:	83 ec 04             	sub    $0x4,%esp
801038d7:	01 c6                	add    %eax,%esi
801038d9:	56                   	push   %esi
801038da:	50                   	push   %eax
801038db:	ff 73 04             	pushl  0x4(%ebx)
801038de:	e8 7d 33 00 00       	call   80106c60 <allocuvm>
801038e3:	83 c4 10             	add    $0x10,%esp
801038e6:	85 c0                	test   %eax,%eax
801038e8:	74 36                	je     80103920 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
801038ea:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801038ed:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801038ef:	53                   	push   %ebx
801038f0:	e8 1b 31 00 00       	call   80106a10 <switchuvm>
  return 0;
801038f5:	83 c4 10             	add    $0x10,%esp
801038f8:	31 c0                	xor    %eax,%eax
}
801038fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038fd:	5b                   	pop    %ebx
801038fe:	5e                   	pop    %esi
801038ff:	5d                   	pop    %ebp
80103900:	c3                   	ret    
80103901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103908:	74 e0                	je     801038ea <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010390a:	83 ec 04             	sub    $0x4,%esp
8010390d:	01 c6                	add    %eax,%esi
8010390f:	56                   	push   %esi
80103910:	50                   	push   %eax
80103911:	ff 73 04             	pushl  0x4(%ebx)
80103914:	e8 47 34 00 00       	call   80106d60 <deallocuvm>
80103919:	83 c4 10             	add    $0x10,%esp
8010391c:	85 c0                	test   %eax,%eax
8010391e:	75 ca                	jne    801038ea <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103925:	eb d3                	jmp    801038fa <growproc+0x4a>
80103927:	89 f6                	mov    %esi,%esi
80103929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103930 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	57                   	push   %edi
80103934:	56                   	push   %esi
80103935:	53                   	push   %ebx
80103936:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103939:	e8 c2 0a 00 00       	call   80104400 <pushcli>
  c = mycpu();
8010393e:	e8 ad fd ff ff       	call   801036f0 <mycpu>
  p = c->proc;
80103943:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103949:	e8 a2 0b 00 00       	call   801044f0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
8010394e:	e8 5d fc ff ff       	call   801035b0 <allocproc>
80103953:	85 c0                	test   %eax,%eax
80103955:	89 c7                	mov    %eax,%edi
80103957:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010395a:	0f 84 b5 00 00 00    	je     80103a15 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103960:	83 ec 08             	sub    $0x8,%esp
80103963:	ff 33                	pushl  (%ebx)
80103965:	ff 73 04             	pushl  0x4(%ebx)
80103968:	e8 73 35 00 00       	call   80106ee0 <copyuvm>
8010396d:	83 c4 10             	add    $0x10,%esp
80103970:	85 c0                	test   %eax,%eax
80103972:	89 47 04             	mov    %eax,0x4(%edi)
80103975:	0f 84 a1 00 00 00    	je     80103a1c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
8010397b:	8b 03                	mov    (%ebx),%eax
8010397d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103980:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103982:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103985:	89 c8                	mov    %ecx,%eax
80103987:	8b 79 18             	mov    0x18(%ecx),%edi
8010398a:	8b 73 18             	mov    0x18(%ebx),%esi
8010398d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103992:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103994:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103996:	8b 40 18             	mov    0x18(%eax),%eax
80103999:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
801039a0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801039a4:	85 c0                	test   %eax,%eax
801039a6:	74 13                	je     801039bb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039a8:	83 ec 0c             	sub    $0xc,%esp
801039ab:	50                   	push   %eax
801039ac:	e8 2f d4 ff ff       	call   80100de0 <filedup>
801039b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039b4:	83 c4 10             	add    $0x10,%esp
801039b7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801039bb:	83 c6 01             	add    $0x1,%esi
801039be:	83 fe 10             	cmp    $0x10,%esi
801039c1:	75 dd                	jne    801039a0 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039c3:	83 ec 0c             	sub    $0xc,%esp
801039c6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039c9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039cc:	e8 6f dc ff ff       	call   80101640 <idup>
801039d1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039d4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801039d7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039da:	8d 47 6c             	lea    0x6c(%edi),%eax
801039dd:	6a 10                	push   $0x10
801039df:	53                   	push   %ebx
801039e0:	50                   	push   %eax
801039e1:	e8 ca 0d 00 00       	call   801047b0 <safestrcpy>

  pid = np->pid;
801039e6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801039e9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039f0:	e8 4b 0a 00 00       	call   80104440 <acquire>

  np->state = RUNNABLE;
801039f5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801039fc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a03:	e8 58 0b 00 00       	call   80104560 <release>

  return pid;
80103a08:	83 c4 10             	add    $0x10,%esp
80103a0b:	89 d8                	mov    %ebx,%eax
}
80103a0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a10:	5b                   	pop    %ebx
80103a11:	5e                   	pop    %esi
80103a12:	5f                   	pop    %edi
80103a13:	5d                   	pop    %ebp
80103a14:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103a15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a1a:	eb f1                	jmp    80103a0d <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103a1c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103a1f:	83 ec 0c             	sub    $0xc,%esp
80103a22:	ff 77 08             	pushl  0x8(%edi)
80103a25:	e8 b6 e8 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103a2a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103a31:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103a38:	83 c4 10             	add    $0x10,%esp
80103a3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a40:	eb cb                	jmp    80103a0d <fork+0xdd>
80103a42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a50 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	57                   	push   %edi
80103a54:	56                   	push   %esi
80103a55:	53                   	push   %ebx
80103a56:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103a59:	e8 92 fc ff ff       	call   801036f0 <mycpu>
  c->proc = 0;
80103a5e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103a65:	00 00 00 
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
80103a68:	89 c6                	mov    %eax,%esi
80103a6a:	8d 40 04             	lea    0x4(%eax),%eax
80103a6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}

static inline void
sti(void)
{
  asm volatile("sti");
80103a70:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a71:	83 ec 0c             	sub    $0xc,%esp
80103a74:	31 ff                	xor    %edi,%edi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a76:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103a7b:	68 20 2d 11 80       	push   $0x80112d20
80103a80:	e8 bb 09 00 00       	call   80104440 <acquire>
80103a85:	83 c4 10             	add    $0x10,%esp
80103a88:	eb 11                	jmp    80103a9b <scheduler+0x4b>
80103a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a90:	83 eb 80             	sub    $0xffffff80,%ebx
80103a93:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103a99:	74 49                	je     80103ae4 <scheduler+0x94>
      if(p->state != RUNNABLE)
80103a9b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103a9f:	75 ef                	jne    80103a90 <scheduler+0x40>
		count++;
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103aa1:	83 ec 0c             	sub    $0xc,%esp
	if(p->state == RUNNABLE|| p->state == RUNNING )
		count++;
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103aa4:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
	if(p->state == RUNNABLE|| p->state == RUNNING )
		count++;
80103aaa:	83 c7 01             	add    $0x1,%edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103aad:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103aae:	83 eb 80             	sub    $0xffffff80,%ebx
		count++;
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103ab1:	e8 5a 2f 00 00       	call   80106a10 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103ab6:	59                   	pop    %ecx
80103ab7:	58                   	pop    %eax
80103ab8:	ff 73 9c             	pushl  -0x64(%ebx)
80103abb:	ff 75 e4             	pushl  -0x1c(%ebp)
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103abe:	c7 43 8c 04 00 00 00 	movl   $0x4,-0x74(%ebx)

      swtch(&(c->scheduler), p->context);
80103ac5:	e8 41 0d 00 00       	call   8010480b <swtch>
      switchkvm();
80103aca:	e8 21 2f 00 00       	call   801069f0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103acf:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ad2:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103ad8:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103adf:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ae2:	75 b7                	jne    80103a9b <scheduler+0x4b>
80103ae4:	b9 07 00 00 00       	mov    $0x7,%ecx
80103ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103af0:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103af5:	eb 14                	jmp    80103b0b <scheduler+0xbb>
80103af7:	89 f6                	mov    %esi,%esi
80103af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
int N=7;
while(N>0){
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b00:	83 eb 80             	sub    $0xffffff80,%ebx
80103b03:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103b09:	74 55                	je     80103b60 <scheduler+0x110>
	
	if(count>3)
80103b0b:	83 ff 03             	cmp    $0x3,%edi
80103b0e:	7e f0                	jle    80103b00 <scheduler+0xb0>
	   if(p->state==RUNNABLE|| p->state == RUNNING)
80103b10:	8b 43 0c             	mov    0xc(%ebx),%eax
80103b13:	83 e8 03             	sub    $0x3,%eax
80103b16:	83 f8 01             	cmp    $0x1,%eax
80103b19:	77 e5                	ja     80103b00 <scheduler+0xb0>
		if(p->priority==N){
80103b1b:	39 4b 7c             	cmp    %ecx,0x7c(%ebx)
80103b1e:	75 e0                	jne    80103b00 <scheduler+0xb0>
		cprintf("now count = %d\n",count);
80103b20:	83 ec 08             	sub    $0x8,%esp
80103b23:	89 4d e0             	mov    %ecx,-0x20(%ebp)
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
int N=7;
while(N>0){
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b26:	83 eb 80             	sub    $0xffffff80,%ebx
	
	if(count>3)
	   if(p->state==RUNNABLE|| p->state == RUNNING)
		if(p->priority==N){
		cprintf("now count = %d\n",count);
80103b29:	57                   	push   %edi
80103b2a:	68 50 76 10 80       	push   $0x80107650
		p->state=SLEEPING;
		count--;cprintf("now count = %d\n",count);
80103b2f:	83 ef 01             	sub    $0x1,%edi
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
	
	if(count>3)
	   if(p->state==RUNNABLE|| p->state == RUNNING)
		if(p->priority==N){
		cprintf("now count = %d\n",count);
80103b32:	e8 29 cb ff ff       	call   80100660 <cprintf>
		p->state=SLEEPING;
		count--;cprintf("now count = %d\n",count);
80103b37:	58                   	pop    %eax
80103b38:	5a                   	pop    %edx
80103b39:	57                   	push   %edi
80103b3a:	68 50 76 10 80       	push   $0x80107650
	
	if(count>3)
	   if(p->state==RUNNABLE|| p->state == RUNNING)
		if(p->priority==N){
		cprintf("now count = %d\n",count);
		p->state=SLEEPING;
80103b3f:	c7 43 8c 02 00 00 00 	movl   $0x2,-0x74(%ebx)
		count--;cprintf("now count = %d\n",count);
80103b46:	e8 15 cb ff ff       	call   80100660 <cprintf>
80103b4b:	83 c4 10             	add    $0x10,%esp
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
int N=7;
while(N>0){
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b4e:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
	if(count>3)
	   if(p->state==RUNNABLE|| p->state == RUNNING)
		if(p->priority==N){
		cprintf("now count = %d\n",count);
		p->state=SLEEPING;
		count--;cprintf("now count = %d\n",count);
80103b54:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
int N=7;
while(N>0){
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b57:	75 b2                	jne    80103b0b <scheduler+0xbb>
80103b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
int N=7;
while(N>0){
80103b60:	83 e9 01             	sub    $0x1,%ecx
80103b63:	75 8b                	jne    80103af0 <scheduler+0xa0>
	}
}
N--;
}

    release(&ptable.lock);
80103b65:	83 ec 0c             	sub    $0xc,%esp
80103b68:	68 20 2d 11 80       	push   $0x80112d20
80103b6d:	e8 ee 09 00 00       	call   80104560 <release>
	count=0;

  }
80103b72:	83 c4 10             	add    $0x10,%esp
80103b75:	e9 f6 fe ff ff       	jmp    80103a70 <scheduler+0x20>
80103b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b80 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	56                   	push   %esi
80103b84:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b85:	e8 76 08 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103b8a:	e8 61 fb ff ff       	call   801036f0 <mycpu>
  p = c->proc;
80103b8f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b95:	e8 56 09 00 00       	call   801044f0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103b9a:	83 ec 0c             	sub    $0xc,%esp
80103b9d:	68 20 2d 11 80       	push   $0x80112d20
80103ba2:	e8 19 08 00 00       	call   801043c0 <holding>
80103ba7:	83 c4 10             	add    $0x10,%esp
80103baa:	85 c0                	test   %eax,%eax
80103bac:	74 4f                	je     80103bfd <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103bae:	e8 3d fb ff ff       	call   801036f0 <mycpu>
80103bb3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103bba:	75 68                	jne    80103c24 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103bbc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103bc0:	74 55                	je     80103c17 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103bc2:	9c                   	pushf  
80103bc3:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103bc4:	f6 c4 02             	test   $0x2,%ah
80103bc7:	75 41                	jne    80103c0a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103bc9:	e8 22 fb ff ff       	call   801036f0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103bce:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103bd1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103bd7:	e8 14 fb ff ff       	call   801036f0 <mycpu>
80103bdc:	83 ec 08             	sub    $0x8,%esp
80103bdf:	ff 70 04             	pushl  0x4(%eax)
80103be2:	53                   	push   %ebx
80103be3:	e8 23 0c 00 00       	call   8010480b <swtch>
  mycpu()->intena = intena;
80103be8:	e8 03 fb ff ff       	call   801036f0 <mycpu>
}
80103bed:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103bf0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bf6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bf9:	5b                   	pop    %ebx
80103bfa:	5e                   	pop    %esi
80103bfb:	5d                   	pop    %ebp
80103bfc:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103bfd:	83 ec 0c             	sub    $0xc,%esp
80103c00:	68 60 76 10 80       	push   $0x80107660
80103c05:	e8 66 c7 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103c0a:	83 ec 0c             	sub    $0xc,%esp
80103c0d:	68 8c 76 10 80       	push   $0x8010768c
80103c12:	e8 59 c7 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103c17:	83 ec 0c             	sub    $0xc,%esp
80103c1a:	68 7e 76 10 80       	push   $0x8010767e
80103c1f:	e8 4c c7 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103c24:	83 ec 0c             	sub    $0xc,%esp
80103c27:	68 72 76 10 80       	push   $0x80107672
80103c2c:	e8 3f c7 ff ff       	call   80100370 <panic>
80103c31:	eb 0d                	jmp    80103c40 <exit>
80103c33:	90                   	nop
80103c34:	90                   	nop
80103c35:	90                   	nop
80103c36:	90                   	nop
80103c37:	90                   	nop
80103c38:	90                   	nop
80103c39:	90                   	nop
80103c3a:	90                   	nop
80103c3b:	90                   	nop
80103c3c:	90                   	nop
80103c3d:	90                   	nop
80103c3e:	90                   	nop
80103c3f:	90                   	nop

80103c40 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	57                   	push   %edi
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c49:	e8 b2 07 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103c4e:	e8 9d fa ff ff       	call   801036f0 <mycpu>
  p = c->proc;
80103c53:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103c59:	e8 92 08 00 00       	call   801044f0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103c5e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103c64:	8d 5e 28             	lea    0x28(%esi),%ebx
80103c67:	8d 7e 68             	lea    0x68(%esi),%edi
80103c6a:	0f 84 e7 00 00 00    	je     80103d57 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103c70:	8b 03                	mov    (%ebx),%eax
80103c72:	85 c0                	test   %eax,%eax
80103c74:	74 12                	je     80103c88 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103c76:	83 ec 0c             	sub    $0xc,%esp
80103c79:	50                   	push   %eax
80103c7a:	e8 b1 d1 ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103c7f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103c85:	83 c4 10             	add    $0x10,%esp
80103c88:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103c8b:	39 df                	cmp    %ebx,%edi
80103c8d:	75 e1                	jne    80103c70 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c8f:	e8 bc ee ff ff       	call   80102b50 <begin_op>
  iput(curproc->cwd);
80103c94:	83 ec 0c             	sub    $0xc,%esp
80103c97:	ff 76 68             	pushl  0x68(%esi)
80103c9a:	e8 01 db ff ff       	call   801017a0 <iput>
  end_op();
80103c9f:	e8 1c ef ff ff       	call   80102bc0 <end_op>
  curproc->cwd = 0;
80103ca4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103cab:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cb2:	e8 89 07 00 00       	call   80104440 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103cb7:	8b 56 14             	mov    0x14(%esi),%edx
80103cba:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cbd:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103cc2:	eb 0e                	jmp    80103cd2 <exit+0x92>
80103cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103cc8:	83 e8 80             	sub    $0xffffff80,%eax
80103ccb:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103cd0:	74 1c                	je     80103cee <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103cd2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cd6:	75 f0                	jne    80103cc8 <exit+0x88>
80103cd8:	3b 50 20             	cmp    0x20(%eax),%edx
80103cdb:	75 eb                	jne    80103cc8 <exit+0x88>
      p->state = RUNNABLE;
80103cdd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ce4:	83 e8 80             	sub    $0xffffff80,%eax
80103ce7:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103cec:	75 e4                	jne    80103cd2 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103cee:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80103cf4:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103cf9:	eb 10                	jmp    80103d0b <exit+0xcb>
80103cfb:	90                   	nop
80103cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d00:	83 ea 80             	sub    $0xffffff80,%edx
80103d03:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103d09:	74 33                	je     80103d3e <exit+0xfe>
    if(p->parent == curproc){
80103d0b:	39 72 14             	cmp    %esi,0x14(%edx)
80103d0e:	75 f0                	jne    80103d00 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103d10:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103d14:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d17:	75 e7                	jne    80103d00 <exit+0xc0>
80103d19:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d1e:	eb 0a                	jmp    80103d2a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d20:	83 e8 80             	sub    $0xffffff80,%eax
80103d23:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103d28:	74 d6                	je     80103d00 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103d2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d2e:	75 f0                	jne    80103d20 <exit+0xe0>
80103d30:	3b 48 20             	cmp    0x20(%eax),%ecx
80103d33:	75 eb                	jne    80103d20 <exit+0xe0>
      p->state = RUNNABLE;
80103d35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d3c:	eb e2                	jmp    80103d20 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103d3e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103d45:	e8 36 fe ff ff       	call   80103b80 <sched>
  panic("zombie exit");
80103d4a:	83 ec 0c             	sub    $0xc,%esp
80103d4d:	68 ad 76 10 80       	push   $0x801076ad
80103d52:	e8 19 c6 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103d57:	83 ec 0c             	sub    $0xc,%esp
80103d5a:	68 a0 76 10 80       	push   $0x801076a0
80103d5f:	e8 0c c6 ff ff       	call   80100370 <panic>
80103d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103d70 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	53                   	push   %ebx
80103d74:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d77:	68 20 2d 11 80       	push   $0x80112d20
80103d7c:	e8 bf 06 00 00       	call   80104440 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d81:	e8 7a 06 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103d86:	e8 65 f9 ff ff       	call   801036f0 <mycpu>
  p = c->proc;
80103d8b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d91:	e8 5a 07 00 00       	call   801044f0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103d96:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103d9d:	e8 de fd ff ff       	call   80103b80 <sched>
  release(&ptable.lock);
80103da2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103da9:	e8 b2 07 00 00       	call   80104560 <release>
}
80103dae:	83 c4 10             	add    $0x10,%esp
80103db1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103db4:	c9                   	leave  
80103db5:	c3                   	ret    
80103db6:	8d 76 00             	lea    0x0(%esi),%esi
80103db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dc0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 0c             	sub    $0xc,%esp
80103dc9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103dcc:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103dcf:	e8 2c 06 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103dd4:	e8 17 f9 ff ff       	call   801036f0 <mycpu>
  p = c->proc;
80103dd9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ddf:	e8 0c 07 00 00       	call   801044f0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103de4:	85 db                	test   %ebx,%ebx
80103de6:	0f 84 87 00 00 00    	je     80103e73 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103dec:	85 f6                	test   %esi,%esi
80103dee:	74 76                	je     80103e66 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103df0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103df6:	74 50                	je     80103e48 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103df8:	83 ec 0c             	sub    $0xc,%esp
80103dfb:	68 20 2d 11 80       	push   $0x80112d20
80103e00:	e8 3b 06 00 00       	call   80104440 <acquire>
    release(lk);
80103e05:	89 34 24             	mov    %esi,(%esp)
80103e08:	e8 53 07 00 00       	call   80104560 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103e0d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e10:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103e17:	e8 64 fd ff ff       	call   80103b80 <sched>

  // Tidy up.
  p->chan = 0;
80103e1c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103e23:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e2a:	e8 31 07 00 00       	call   80104560 <release>
    acquire(lk);
80103e2f:	89 75 08             	mov    %esi,0x8(%ebp)
80103e32:	83 c4 10             	add    $0x10,%esp
  }
}
80103e35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e38:	5b                   	pop    %ebx
80103e39:	5e                   	pop    %esi
80103e3a:	5f                   	pop    %edi
80103e3b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103e3c:	e9 ff 05 00 00       	jmp    80104440 <acquire>
80103e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103e48:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e4b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103e52:	e8 29 fd ff ff       	call   80103b80 <sched>

  // Tidy up.
  p->chan = 0;
80103e57:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103e5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e61:	5b                   	pop    %ebx
80103e62:	5e                   	pop    %esi
80103e63:	5f                   	pop    %edi
80103e64:	5d                   	pop    %ebp
80103e65:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103e66:	83 ec 0c             	sub    $0xc,%esp
80103e69:	68 bf 76 10 80       	push   $0x801076bf
80103e6e:	e8 fd c4 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103e73:	83 ec 0c             	sub    $0xc,%esp
80103e76:	68 b9 76 10 80       	push   $0x801076b9
80103e7b:	e8 f0 c4 ff ff       	call   80100370 <panic>

80103e80 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	56                   	push   %esi
80103e84:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e85:	e8 76 05 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103e8a:	e8 61 f8 ff ff       	call   801036f0 <mycpu>
  p = c->proc;
80103e8f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e95:	e8 56 06 00 00       	call   801044f0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103e9a:	83 ec 0c             	sub    $0xc,%esp
80103e9d:	68 20 2d 11 80       	push   $0x80112d20
80103ea2:	e8 99 05 00 00       	call   80104440 <acquire>
80103ea7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103eaa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eac:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103eb1:	eb 10                	jmp    80103ec3 <wait+0x43>
80103eb3:	90                   	nop
80103eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103eb8:	83 eb 80             	sub    $0xffffff80,%ebx
80103ebb:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103ec1:	74 1d                	je     80103ee0 <wait+0x60>
      if(p->parent != curproc)
80103ec3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ec6:	75 f0                	jne    80103eb8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103ec8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103ecc:	74 30                	je     80103efe <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ece:	83 eb 80             	sub    $0xffffff80,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103ed1:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ed6:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103edc:	75 e5                	jne    80103ec3 <wait+0x43>
80103ede:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103ee0:	85 c0                	test   %eax,%eax
80103ee2:	74 70                	je     80103f54 <wait+0xd4>
80103ee4:	8b 46 24             	mov    0x24(%esi),%eax
80103ee7:	85 c0                	test   %eax,%eax
80103ee9:	75 69                	jne    80103f54 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103eeb:	83 ec 08             	sub    $0x8,%esp
80103eee:	68 20 2d 11 80       	push   $0x80112d20
80103ef3:	56                   	push   %esi
80103ef4:	e8 c7 fe ff ff       	call   80103dc0 <sleep>
  }
80103ef9:	83 c4 10             	add    $0x10,%esp
80103efc:	eb ac                	jmp    80103eaa <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103efe:	83 ec 0c             	sub    $0xc,%esp
80103f01:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103f04:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f07:	e8 d4 e3 ff ff       	call   801022e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103f0c:	5a                   	pop    %edx
80103f0d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103f10:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f17:	e8 74 2e 00 00       	call   80106d90 <freevm>
        p->pid = 0;
80103f1c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f23:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f2a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f2e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f35:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f3c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f43:	e8 18 06 00 00       	call   80104560 <release>
        return pid;
80103f48:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f4b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103f4e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f50:	5b                   	pop    %ebx
80103f51:	5e                   	pop    %esi
80103f52:	5d                   	pop    %ebp
80103f53:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103f54:	83 ec 0c             	sub    $0xc,%esp
80103f57:	68 20 2d 11 80       	push   $0x80112d20
80103f5c:	e8 ff 05 00 00       	call   80104560 <release>
      return -1;
80103f61:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f64:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80103f67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f6c:	5b                   	pop    %ebx
80103f6d:	5e                   	pop    %esi
80103f6e:	5d                   	pop    %ebp
80103f6f:	c3                   	ret    

80103f70 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	53                   	push   %ebx
80103f74:	83 ec 10             	sub    $0x10,%esp
80103f77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f7a:	68 20 2d 11 80       	push   $0x80112d20
80103f7f:	e8 bc 04 00 00       	call   80104440 <acquire>
80103f84:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f87:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f8c:	eb 0c                	jmp    80103f9a <wakeup+0x2a>
80103f8e:	66 90                	xchg   %ax,%ax
80103f90:	83 e8 80             	sub    $0xffffff80,%eax
80103f93:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103f98:	74 1c                	je     80103fb6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103f9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f9e:	75 f0                	jne    80103f90 <wakeup+0x20>
80103fa0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103fa3:	75 eb                	jne    80103f90 <wakeup+0x20>
      p->state = RUNNABLE;
80103fa5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fac:	83 e8 80             	sub    $0xffffff80,%eax
80103faf:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103fb4:	75 e4                	jne    80103f9a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103fb6:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103fbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fc0:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103fc1:	e9 9a 05 00 00       	jmp    80104560 <release>
80103fc6:	8d 76 00             	lea    0x0(%esi),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fd0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	53                   	push   %ebx
80103fd4:	83 ec 10             	sub    $0x10,%esp
80103fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103fda:	68 20 2d 11 80       	push   $0x80112d20
80103fdf:	e8 5c 04 00 00       	call   80104440 <acquire>
80103fe4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fe7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103fec:	eb 0c                	jmp    80103ffa <kill+0x2a>
80103fee:	66 90                	xchg   %ax,%ax
80103ff0:	83 e8 80             	sub    $0xffffff80,%eax
80103ff3:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103ff8:	74 3e                	je     80104038 <kill+0x68>
    if(p->pid == pid){
80103ffa:	39 58 10             	cmp    %ebx,0x10(%eax)
80103ffd:	75 f1                	jne    80103ff0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103fff:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104003:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010400a:	74 1c                	je     80104028 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010400c:	83 ec 0c             	sub    $0xc,%esp
8010400f:	68 20 2d 11 80       	push   $0x80112d20
80104014:	e8 47 05 00 00       	call   80104560 <release>
      return 0;
80104019:	83 c4 10             	add    $0x10,%esp
8010401c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010401e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104021:	c9                   	leave  
80104022:	c3                   	ret    
80104023:	90                   	nop
80104024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104028:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010402f:	eb db                	jmp    8010400c <kill+0x3c>
80104031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104038:	83 ec 0c             	sub    $0xc,%esp
8010403b:	68 20 2d 11 80       	push   $0x80112d20
80104040:	e8 1b 05 00 00       	call   80104560 <release>
  return -1;
80104045:	83 c4 10             	add    $0x10,%esp
80104048:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010404d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104050:	c9                   	leave  
80104051:	c3                   	ret    
80104052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104060 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	57                   	push   %edi
80104064:	56                   	push   %esi
80104065:	53                   	push   %ebx
80104066:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104069:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010406e:	83 ec 3c             	sub    $0x3c,%esp
80104071:	eb 24                	jmp    80104097 <procdump+0x37>
80104073:	90                   	nop
80104074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104078:	83 ec 0c             	sub    $0xc,%esp
8010407b:	68 bf 7a 10 80       	push   $0x80107abf
80104080:	e8 db c5 ff ff       	call   80100660 <cprintf>
80104085:	83 c4 10             	add    $0x10,%esp
80104088:	83 eb 80             	sub    $0xffffff80,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010408b:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
80104091:	0f 84 81 00 00 00    	je     80104118 <procdump+0xb8>
    if(p->state == UNUSED)
80104097:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010409a:	85 c0                	test   %eax,%eax
8010409c:	74 ea                	je     80104088 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010409e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801040a1:	ba d0 76 10 80       	mov    $0x801076d0,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040a6:	77 11                	ja     801040b9 <procdump+0x59>
801040a8:	8b 14 85 a0 77 10 80 	mov    -0x7fef8860(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801040af:	b8 d0 76 10 80       	mov    $0x801076d0,%eax
801040b4:	85 d2                	test   %edx,%edx
801040b6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801040b9:	53                   	push   %ebx
801040ba:	52                   	push   %edx
801040bb:	ff 73 a4             	pushl  -0x5c(%ebx)
801040be:	68 d4 76 10 80       	push   $0x801076d4
801040c3:	e8 98 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801040c8:	83 c4 10             	add    $0x10,%esp
801040cb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801040cf:	75 a7                	jne    80104078 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801040d1:	8d 45 c0             	lea    -0x40(%ebp),%eax
801040d4:	83 ec 08             	sub    $0x8,%esp
801040d7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801040da:	50                   	push   %eax
801040db:	8b 43 b0             	mov    -0x50(%ebx),%eax
801040de:	8b 40 0c             	mov    0xc(%eax),%eax
801040e1:	83 c0 08             	add    $0x8,%eax
801040e4:	50                   	push   %eax
801040e5:	e8 76 02 00 00       	call   80104360 <getcallerpcs>
801040ea:	83 c4 10             	add    $0x10,%esp
801040ed:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801040f0:	8b 17                	mov    (%edi),%edx
801040f2:	85 d2                	test   %edx,%edx
801040f4:	74 82                	je     80104078 <procdump+0x18>
        cprintf(" %p", pc[i]);
801040f6:	83 ec 08             	sub    $0x8,%esp
801040f9:	83 c7 04             	add    $0x4,%edi
801040fc:	52                   	push   %edx
801040fd:	68 01 71 10 80       	push   $0x80107101
80104102:	e8 59 c5 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104107:	83 c4 10             	add    $0x10,%esp
8010410a:	39 f7                	cmp    %esi,%edi
8010410c:	75 e2                	jne    801040f0 <procdump+0x90>
8010410e:	e9 65 ff ff ff       	jmp    80104078 <procdump+0x18>
80104113:	90                   	nop
80104114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104118:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010411b:	5b                   	pop    %ebx
8010411c:	5e                   	pop    %esi
8010411d:	5f                   	pop    %edi
8010411e:	5d                   	pop    %ebp
8010411f:	c3                   	ret    

80104120 <cps>:
int
cps()
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	53                   	push   %ebx
80104124:	83 ec 10             	sub    $0x10,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
80104127:	fb                   	sti    
struct proc *p;
sti();
acquire(&ptable.lock);
80104128:	68 20 2d 11 80       	push   $0x80112d20
8010412d:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80104132:	e8 09 03 00 00       	call   80104440 <acquire>
cprintf("name \t pid \t state \t \t priority \n");
80104137:	c7 04 24 7c 77 10 80 	movl   $0x8010777c,(%esp)
8010413e:	e8 1d c5 ff ff       	call   80100660 <cprintf>
80104143:	83 c4 10             	add    $0x10,%esp
80104146:	eb 1d                	jmp    80104165 <cps+0x45>
80104148:	90                   	nop
80104149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == SLEEPING)
	cprintf("%s \t %d  \t SLEEPING \t %d\n", p->name , p->pid, p->priority);
    else if(p->state == RUNNING)
80104150:	83 f8 04             	cmp    $0x4,%eax
80104153:	74 4b                	je     801041a0 <cps+0x80>
	cprintf("%s \t %d  \t RUNNING \t %d\n", p->name , p->pid, p->priority);
    else if(p->state == RUNNABLE)
80104155:	83 f8 03             	cmp    $0x3,%eax
80104158:	74 66                	je     801041c0 <cps+0xa0>
8010415a:	83 eb 80             	sub    $0xffffff80,%ebx
{
struct proc *p;
sti();
acquire(&ptable.lock);
cprintf("name \t pid \t state \t \t priority \n");
 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010415d:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
80104163:	74 27                	je     8010418c <cps+0x6c>
    if(p->state == SLEEPING)
80104165:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104168:	83 f8 02             	cmp    $0x2,%eax
8010416b:	75 e3                	jne    80104150 <cps+0x30>
	cprintf("%s \t %d  \t SLEEPING \t %d\n", p->name , p->pid, p->priority);
8010416d:	ff 73 10             	pushl  0x10(%ebx)
80104170:	ff 73 a4             	pushl  -0x5c(%ebx)
80104173:	53                   	push   %ebx
80104174:	68 dd 76 10 80       	push   $0x801076dd
80104179:	83 eb 80             	sub    $0xffffff80,%ebx
8010417c:	e8 df c4 ff ff       	call   80100660 <cprintf>
80104181:	83 c4 10             	add    $0x10,%esp
{
struct proc *p;
sti();
acquire(&ptable.lock);
cprintf("name \t pid \t state \t \t priority \n");
 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104184:	81 fb c0 4d 11 80    	cmp    $0x80114dc0,%ebx
8010418a:	75 d9                	jne    80104165 <cps+0x45>
	cprintf("%s \t %d  \t RUNNING \t %d\n", p->name , p->pid, p->priority);
    else if(p->state == RUNNABLE)
	cprintf("%s \t %d  \t RUNNABLE \t %d\n", p->name , p->pid, p->priority);

}
release(&ptable.lock);
8010418c:	83 ec 0c             	sub    $0xc,%esp
8010418f:	68 20 2d 11 80       	push   $0x80112d20
80104194:	e8 c7 03 00 00       	call   80104560 <release>
return 0;
}
80104199:	31 c0                	xor    %eax,%eax
8010419b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010419e:	c9                   	leave  
8010419f:	c3                   	ret    
cprintf("name \t pid \t state \t \t priority \n");
 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == SLEEPING)
	cprintf("%s \t %d  \t SLEEPING \t %d\n", p->name , p->pid, p->priority);
    else if(p->state == RUNNING)
	cprintf("%s \t %d  \t RUNNING \t %d\n", p->name , p->pid, p->priority);
801041a0:	ff 73 10             	pushl  0x10(%ebx)
801041a3:	ff 73 a4             	pushl  -0x5c(%ebx)
801041a6:	53                   	push   %ebx
801041a7:	68 f7 76 10 80       	push   $0x801076f7
801041ac:	e8 af c4 ff ff       	call   80100660 <cprintf>
801041b1:	83 c4 10             	add    $0x10,%esp
801041b4:	eb a4                	jmp    8010415a <cps+0x3a>
801041b6:	8d 76 00             	lea    0x0(%esi),%esi
801041b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    else if(p->state == RUNNABLE)
	cprintf("%s \t %d  \t RUNNABLE \t %d\n", p->name , p->pid, p->priority);
801041c0:	ff 73 10             	pushl  0x10(%ebx)
801041c3:	ff 73 a4             	pushl  -0x5c(%ebx)
801041c6:	53                   	push   %ebx
801041c7:	68 10 77 10 80       	push   $0x80107710
801041cc:	e8 8f c4 ff ff       	call   80100660 <cprintf>
801041d1:	83 c4 10             	add    $0x10,%esp
801041d4:	eb 84                	jmp    8010415a <cps+0x3a>
801041d6:	8d 76 00             	lea    0x0(%esi),%esi
801041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041e0 <chpr>:
return 0;
}


int 
chpr( int pid, int priority){
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 10             	sub    $0x10,%esp
801041e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
struct proc *p;

acquire(&ptable.lock);
801041ea:	68 20 2d 11 80       	push   $0x80112d20
801041ef:	e8 4c 02 00 00       	call   80104440 <acquire>
801041f4:	83 c4 10             	add    $0x10,%esp
for(p= ptable.proc;p<&ptable.proc[NPROC];p++){
801041f7:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
801041fc:	eb 0d                	jmp    8010420b <chpr+0x2b>
801041fe:	66 90                	xchg   %ax,%ax
80104200:	83 ea 80             	sub    $0xffffff80,%edx
80104203:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80104209:	74 0b                	je     80104216 <chpr+0x36>
if(p->pid==pid){
8010420b:	39 5a 10             	cmp    %ebx,0x10(%edx)
8010420e:	75 f0                	jne    80104200 <chpr+0x20>
p->priority=priority;
80104210:	8b 45 0c             	mov    0xc(%ebp),%eax
80104213:	89 42 7c             	mov    %eax,0x7c(%edx)
break;
}
}
release(&ptable.lock);
80104216:	83 ec 0c             	sub    $0xc,%esp
80104219:	68 20 2d 11 80       	push   $0x80112d20
8010421e:	e8 3d 03 00 00       	call   80104560 <release>
return pid;
}
80104223:	89 d8                	mov    %ebx,%eax
80104225:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104228:	c9                   	leave  
80104229:	c3                   	ret    
8010422a:	66 90                	xchg   %ax,%ax
8010422c:	66 90                	xchg   %ax,%ax
8010422e:	66 90                	xchg   %ax,%ax

80104230 <initsleeplock>:
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	53                   	push   %ebx
80104234:	83 ec 0c             	sub    $0xc,%esp
80104237:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010423a:	68 b8 77 10 80       	push   $0x801077b8
8010423f:	8d 43 04             	lea    0x4(%ebx),%eax
80104242:	50                   	push   %eax
80104243:	e8 f8 00 00 00       	call   80104340 <initlock>
80104248:	8b 45 0c             	mov    0xc(%ebp),%eax
8010424b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104251:	83 c4 10             	add    $0x10,%esp
80104254:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
8010425b:	89 43 38             	mov    %eax,0x38(%ebx)
8010425e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104261:	c9                   	leave  
80104262:	c3                   	ret    
80104263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104270 <acquiresleep>:
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	56                   	push   %esi
80104274:	53                   	push   %ebx
80104275:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	8d 73 04             	lea    0x4(%ebx),%esi
8010427e:	56                   	push   %esi
8010427f:	e8 bc 01 00 00       	call   80104440 <acquire>
80104284:	8b 13                	mov    (%ebx),%edx
80104286:	83 c4 10             	add    $0x10,%esp
80104289:	85 d2                	test   %edx,%edx
8010428b:	74 16                	je     801042a3 <acquiresleep+0x33>
8010428d:	8d 76 00             	lea    0x0(%esi),%esi
80104290:	83 ec 08             	sub    $0x8,%esp
80104293:	56                   	push   %esi
80104294:	53                   	push   %ebx
80104295:	e8 26 fb ff ff       	call   80103dc0 <sleep>
8010429a:	8b 03                	mov    (%ebx),%eax
8010429c:	83 c4 10             	add    $0x10,%esp
8010429f:	85 c0                	test   %eax,%eax
801042a1:	75 ed                	jne    80104290 <acquiresleep+0x20>
801042a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
801042a9:	e8 e2 f4 ff ff       	call   80103790 <myproc>
801042ae:	8b 40 10             	mov    0x10(%eax),%eax
801042b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
801042b4:	89 75 08             	mov    %esi,0x8(%ebp)
801042b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042ba:	5b                   	pop    %ebx
801042bb:	5e                   	pop    %esi
801042bc:	5d                   	pop    %ebp
801042bd:	e9 9e 02 00 00       	jmp    80104560 <release>
801042c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042d0 <releasesleep>:
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	56                   	push   %esi
801042d4:	53                   	push   %ebx
801042d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042d8:	83 ec 0c             	sub    $0xc,%esp
801042db:	8d 73 04             	lea    0x4(%ebx),%esi
801042de:	56                   	push   %esi
801042df:	e8 5c 01 00 00       	call   80104440 <acquire>
801042e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801042ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
801042f1:	89 1c 24             	mov    %ebx,(%esp)
801042f4:	e8 77 fc ff ff       	call   80103f70 <wakeup>
801042f9:	89 75 08             	mov    %esi,0x8(%ebp)
801042fc:	83 c4 10             	add    $0x10,%esp
801042ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104302:	5b                   	pop    %ebx
80104303:	5e                   	pop    %esi
80104304:	5d                   	pop    %ebp
80104305:	e9 56 02 00 00       	jmp    80104560 <release>
8010430a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104310 <holdingsleep>:
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	56                   	push   %esi
80104314:	53                   	push   %ebx
80104315:	8b 75 08             	mov    0x8(%ebp),%esi
80104318:	83 ec 0c             	sub    $0xc,%esp
8010431b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010431e:	53                   	push   %ebx
8010431f:	e8 1c 01 00 00       	call   80104440 <acquire>
80104324:	8b 36                	mov    (%esi),%esi
80104326:	89 1c 24             	mov    %ebx,(%esp)
80104329:	e8 32 02 00 00       	call   80104560 <release>
8010432e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104331:	89 f0                	mov    %esi,%eax
80104333:	5b                   	pop    %ebx
80104334:	5e                   	pop    %esi
80104335:	5d                   	pop    %ebp
80104336:	c3                   	ret    
80104337:	66 90                	xchg   %ax,%ax
80104339:	66 90                	xchg   %ax,%ax
8010433b:	66 90                	xchg   %ax,%ax
8010433d:	66 90                	xchg   %ax,%ax
8010433f:	90                   	nop

80104340 <initlock>:
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	8b 45 08             	mov    0x8(%ebp),%eax
80104346:	8b 55 0c             	mov    0xc(%ebp),%edx
80104349:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010434f:	89 50 04             	mov    %edx,0x4(%eax)
80104352:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104359:	5d                   	pop    %ebp
8010435a:	c3                   	ret    
8010435b:	90                   	nop
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104360 <getcallerpcs>:
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	8b 45 08             	mov    0x8(%ebp),%eax
80104367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010436a:	8d 50 f8             	lea    -0x8(%eax),%edx
8010436d:	31 c0                	xor    %eax,%eax
8010436f:	90                   	nop
80104370:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104376:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010437c:	77 1a                	ja     80104398 <getcallerpcs+0x38>
8010437e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104381:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
80104384:	83 c0 01             	add    $0x1,%eax
80104387:	8b 12                	mov    (%edx),%edx
80104389:	83 f8 0a             	cmp    $0xa,%eax
8010438c:	75 e2                	jne    80104370 <getcallerpcs+0x10>
8010438e:	5b                   	pop    %ebx
8010438f:	5d                   	pop    %ebp
80104390:	c3                   	ret    
80104391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104398:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
8010439f:	83 c0 01             	add    $0x1,%eax
801043a2:	83 f8 0a             	cmp    $0xa,%eax
801043a5:	74 e7                	je     8010438e <getcallerpcs+0x2e>
801043a7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801043ae:	83 c0 01             	add    $0x1,%eax
801043b1:	83 f8 0a             	cmp    $0xa,%eax
801043b4:	75 e2                	jne    80104398 <getcallerpcs+0x38>
801043b6:	eb d6                	jmp    8010438e <getcallerpcs+0x2e>
801043b8:	90                   	nop
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <holding>:
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
801043c4:	83 ec 04             	sub    $0x4,%esp
801043c7:	8b 55 08             	mov    0x8(%ebp),%edx
801043ca:	8b 02                	mov    (%edx),%eax
801043cc:	85 c0                	test   %eax,%eax
801043ce:	75 10                	jne    801043e0 <holding+0x20>
801043d0:	83 c4 04             	add    $0x4,%esp
801043d3:	31 c0                	xor    %eax,%eax
801043d5:	5b                   	pop    %ebx
801043d6:	5d                   	pop    %ebp
801043d7:	c3                   	ret    
801043d8:	90                   	nop
801043d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043e0:	8b 5a 08             	mov    0x8(%edx),%ebx
801043e3:	e8 08 f3 ff ff       	call   801036f0 <mycpu>
801043e8:	39 c3                	cmp    %eax,%ebx
801043ea:	0f 94 c0             	sete   %al
801043ed:	83 c4 04             	add    $0x4,%esp
801043f0:	0f b6 c0             	movzbl %al,%eax
801043f3:	5b                   	pop    %ebx
801043f4:	5d                   	pop    %ebp
801043f5:	c3                   	ret    
801043f6:	8d 76 00             	lea    0x0(%esi),%esi
801043f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104400 <pushcli>:
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	53                   	push   %ebx
80104404:	83 ec 04             	sub    $0x4,%esp
80104407:	9c                   	pushf  
80104408:	5b                   	pop    %ebx
80104409:	fa                   	cli    
8010440a:	e8 e1 f2 ff ff       	call   801036f0 <mycpu>
8010440f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104415:	85 c0                	test   %eax,%eax
80104417:	75 11                	jne    8010442a <pushcli+0x2a>
80104419:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010441f:	e8 cc f2 ff ff       	call   801036f0 <mycpu>
80104424:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
8010442a:	e8 c1 f2 ff ff       	call   801036f0 <mycpu>
8010442f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104436:	83 c4 04             	add    $0x4,%esp
80104439:	5b                   	pop    %ebx
8010443a:	5d                   	pop    %ebp
8010443b:	c3                   	ret    
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <acquire>:
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
80104444:	53                   	push   %ebx
80104445:	e8 b6 ff ff ff       	call   80104400 <pushcli>
8010444a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010444d:	8b 03                	mov    (%ebx),%eax
8010444f:	85 c0                	test   %eax,%eax
80104451:	75 7d                	jne    801044d0 <acquire+0x90>
80104453:	ba 01 00 00 00       	mov    $0x1,%edx
80104458:	eb 09                	jmp    80104463 <acquire+0x23>
8010445a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104460:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104463:	89 d0                	mov    %edx,%eax
80104465:	f0 87 03             	lock xchg %eax,(%ebx)
80104468:	85 c0                	test   %eax,%eax
8010446a:	75 f4                	jne    80104460 <acquire+0x20>
8010446c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104471:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104474:	e8 77 f2 ff ff       	call   801036f0 <mycpu>
80104479:	89 ea                	mov    %ebp,%edx
8010447b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
8010447e:	89 43 08             	mov    %eax,0x8(%ebx)
80104481:	31 c0                	xor    %eax,%eax
80104483:	90                   	nop
80104484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104488:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010448e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104494:	77 1a                	ja     801044b0 <acquire+0x70>
80104496:	8b 5a 04             	mov    0x4(%edx),%ebx
80104499:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
8010449c:	83 c0 01             	add    $0x1,%eax
8010449f:	8b 12                	mov    (%edx),%edx
801044a1:	83 f8 0a             	cmp    $0xa,%eax
801044a4:	75 e2                	jne    80104488 <acquire+0x48>
801044a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044a9:	5b                   	pop    %ebx
801044aa:	5e                   	pop    %esi
801044ab:	5d                   	pop    %ebp
801044ac:	c3                   	ret    
801044ad:	8d 76 00             	lea    0x0(%esi),%esi
801044b0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801044b7:	83 c0 01             	add    $0x1,%eax
801044ba:	83 f8 0a             	cmp    $0xa,%eax
801044bd:	74 e7                	je     801044a6 <acquire+0x66>
801044bf:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801044c6:	83 c0 01             	add    $0x1,%eax
801044c9:	83 f8 0a             	cmp    $0xa,%eax
801044cc:	75 e2                	jne    801044b0 <acquire+0x70>
801044ce:	eb d6                	jmp    801044a6 <acquire+0x66>
801044d0:	8b 73 08             	mov    0x8(%ebx),%esi
801044d3:	e8 18 f2 ff ff       	call   801036f0 <mycpu>
801044d8:	39 c6                	cmp    %eax,%esi
801044da:	0f 85 73 ff ff ff    	jne    80104453 <acquire+0x13>
801044e0:	83 ec 0c             	sub    $0xc,%esp
801044e3:	68 c3 77 10 80       	push   $0x801077c3
801044e8:	e8 83 be ff ff       	call   80100370 <panic>
801044ed:	8d 76 00             	lea    0x0(%esi),%esi

801044f0 <popcli>:
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	83 ec 08             	sub    $0x8,%esp
801044f6:	9c                   	pushf  
801044f7:	58                   	pop    %eax
801044f8:	f6 c4 02             	test   $0x2,%ah
801044fb:	75 52                	jne    8010454f <popcli+0x5f>
801044fd:	e8 ee f1 ff ff       	call   801036f0 <mycpu>
80104502:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104508:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010450b:	85 d2                	test   %edx,%edx
8010450d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104513:	78 2d                	js     80104542 <popcli+0x52>
80104515:	e8 d6 f1 ff ff       	call   801036f0 <mycpu>
8010451a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104520:	85 d2                	test   %edx,%edx
80104522:	74 0c                	je     80104530 <popcli+0x40>
80104524:	c9                   	leave  
80104525:	c3                   	ret    
80104526:	8d 76 00             	lea    0x0(%esi),%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104530:	e8 bb f1 ff ff       	call   801036f0 <mycpu>
80104535:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010453b:	85 c0                	test   %eax,%eax
8010453d:	74 e5                	je     80104524 <popcli+0x34>
8010453f:	fb                   	sti    
80104540:	c9                   	leave  
80104541:	c3                   	ret    
80104542:	83 ec 0c             	sub    $0xc,%esp
80104545:	68 e2 77 10 80       	push   $0x801077e2
8010454a:	e8 21 be ff ff       	call   80100370 <panic>
8010454f:	83 ec 0c             	sub    $0xc,%esp
80104552:	68 cb 77 10 80       	push   $0x801077cb
80104557:	e8 14 be ff ff       	call   80100370 <panic>
8010455c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104560 <release>:
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	56                   	push   %esi
80104564:	53                   	push   %ebx
80104565:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104568:	8b 03                	mov    (%ebx),%eax
8010456a:	85 c0                	test   %eax,%eax
8010456c:	75 12                	jne    80104580 <release+0x20>
8010456e:	83 ec 0c             	sub    $0xc,%esp
80104571:	68 e9 77 10 80       	push   $0x801077e9
80104576:	e8 f5 bd ff ff       	call   80100370 <panic>
8010457b:	90                   	nop
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104580:	8b 73 08             	mov    0x8(%ebx),%esi
80104583:	e8 68 f1 ff ff       	call   801036f0 <mycpu>
80104588:	39 c6                	cmp    %eax,%esi
8010458a:	75 e2                	jne    8010456e <release+0xe>
8010458c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104593:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
8010459a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
8010459f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801045a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045a8:	5b                   	pop    %ebx
801045a9:	5e                   	pop    %esi
801045aa:	5d                   	pop    %ebp
801045ab:	e9 40 ff ff ff       	jmp    801044f0 <popcli>

801045b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	57                   	push   %edi
801045b4:	53                   	push   %ebx
801045b5:	8b 55 08             	mov    0x8(%ebp),%edx
801045b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801045bb:	f6 c2 03             	test   $0x3,%dl
801045be:	75 05                	jne    801045c5 <memset+0x15>
801045c0:	f6 c1 03             	test   $0x3,%cl
801045c3:	74 13                	je     801045d8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801045c5:	89 d7                	mov    %edx,%edi
801045c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045ca:	fc                   	cld    
801045cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045cd:	5b                   	pop    %ebx
801045ce:	89 d0                	mov    %edx,%eax
801045d0:	5f                   	pop    %edi
801045d1:	5d                   	pop    %ebp
801045d2:	c3                   	ret    
801045d3:	90                   	nop
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801045d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801045dc:	c1 e9 02             	shr    $0x2,%ecx
801045df:	89 fb                	mov    %edi,%ebx
801045e1:	89 f8                	mov    %edi,%eax
801045e3:	c1 e3 18             	shl    $0x18,%ebx
801045e6:	c1 e0 10             	shl    $0x10,%eax
801045e9:	09 d8                	or     %ebx,%eax
801045eb:	09 f8                	or     %edi,%eax
801045ed:	c1 e7 08             	shl    $0x8,%edi
801045f0:	09 f8                	or     %edi,%eax
801045f2:	89 d7                	mov    %edx,%edi
801045f4:	fc                   	cld    
801045f5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045f7:	5b                   	pop    %ebx
801045f8:	89 d0                	mov    %edx,%eax
801045fa:	5f                   	pop    %edi
801045fb:	5d                   	pop    %ebp
801045fc:	c3                   	ret    
801045fd:	8d 76 00             	lea    0x0(%esi),%esi

80104600 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	57                   	push   %edi
80104604:	56                   	push   %esi
80104605:	8b 45 10             	mov    0x10(%ebp),%eax
80104608:	53                   	push   %ebx
80104609:	8b 75 0c             	mov    0xc(%ebp),%esi
8010460c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010460f:	85 c0                	test   %eax,%eax
80104611:	74 29                	je     8010463c <memcmp+0x3c>
    if(*s1 != *s2)
80104613:	0f b6 13             	movzbl (%ebx),%edx
80104616:	0f b6 0e             	movzbl (%esi),%ecx
80104619:	38 d1                	cmp    %dl,%cl
8010461b:	75 2b                	jne    80104648 <memcmp+0x48>
8010461d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104620:	31 c0                	xor    %eax,%eax
80104622:	eb 14                	jmp    80104638 <memcmp+0x38>
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104628:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010462d:	83 c0 01             	add    $0x1,%eax
80104630:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104634:	38 ca                	cmp    %cl,%dl
80104636:	75 10                	jne    80104648 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104638:	39 f8                	cmp    %edi,%eax
8010463a:	75 ec                	jne    80104628 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010463c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010463d:	31 c0                	xor    %eax,%eax
}
8010463f:	5e                   	pop    %esi
80104640:	5f                   	pop    %edi
80104641:	5d                   	pop    %ebp
80104642:	c3                   	ret    
80104643:	90                   	nop
80104644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104648:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010464b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010464c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010464e:	5e                   	pop    %esi
8010464f:	5f                   	pop    %edi
80104650:	5d                   	pop    %ebp
80104651:	c3                   	ret    
80104652:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
80104665:	8b 45 08             	mov    0x8(%ebp),%eax
80104668:	8b 75 0c             	mov    0xc(%ebp),%esi
8010466b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010466e:	39 c6                	cmp    %eax,%esi
80104670:	73 2e                	jae    801046a0 <memmove+0x40>
80104672:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104675:	39 c8                	cmp    %ecx,%eax
80104677:	73 27                	jae    801046a0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104679:	85 db                	test   %ebx,%ebx
8010467b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010467e:	74 17                	je     80104697 <memmove+0x37>
      *--d = *--s;
80104680:	29 d9                	sub    %ebx,%ecx
80104682:	89 cb                	mov    %ecx,%ebx
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104688:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010468c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010468f:	83 ea 01             	sub    $0x1,%edx
80104692:	83 fa ff             	cmp    $0xffffffff,%edx
80104695:	75 f1                	jne    80104688 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104697:	5b                   	pop    %ebx
80104698:	5e                   	pop    %esi
80104699:	5d                   	pop    %ebp
8010469a:	c3                   	ret    
8010469b:	90                   	nop
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801046a0:	31 d2                	xor    %edx,%edx
801046a2:	85 db                	test   %ebx,%ebx
801046a4:	74 f1                	je     80104697 <memmove+0x37>
801046a6:	8d 76 00             	lea    0x0(%esi),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801046b0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801046b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801046b7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801046ba:	39 d3                	cmp    %edx,%ebx
801046bc:	75 f2                	jne    801046b0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801046be:	5b                   	pop    %ebx
801046bf:	5e                   	pop    %esi
801046c0:	5d                   	pop    %ebp
801046c1:	c3                   	ret    
801046c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801046d3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801046d4:	eb 8a                	jmp    80104660 <memmove>
801046d6:	8d 76 00             	lea    0x0(%esi),%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046e0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	57                   	push   %edi
801046e4:	56                   	push   %esi
801046e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046e8:	53                   	push   %ebx
801046e9:	8b 7d 08             	mov    0x8(%ebp),%edi
801046ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801046ef:	85 c9                	test   %ecx,%ecx
801046f1:	74 37                	je     8010472a <strncmp+0x4a>
801046f3:	0f b6 17             	movzbl (%edi),%edx
801046f6:	0f b6 1e             	movzbl (%esi),%ebx
801046f9:	84 d2                	test   %dl,%dl
801046fb:	74 3f                	je     8010473c <strncmp+0x5c>
801046fd:	38 d3                	cmp    %dl,%bl
801046ff:	75 3b                	jne    8010473c <strncmp+0x5c>
80104701:	8d 47 01             	lea    0x1(%edi),%eax
80104704:	01 cf                	add    %ecx,%edi
80104706:	eb 1b                	jmp    80104723 <strncmp+0x43>
80104708:	90                   	nop
80104709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104710:	0f b6 10             	movzbl (%eax),%edx
80104713:	84 d2                	test   %dl,%dl
80104715:	74 21                	je     80104738 <strncmp+0x58>
80104717:	0f b6 19             	movzbl (%ecx),%ebx
8010471a:	83 c0 01             	add    $0x1,%eax
8010471d:	89 ce                	mov    %ecx,%esi
8010471f:	38 da                	cmp    %bl,%dl
80104721:	75 19                	jne    8010473c <strncmp+0x5c>
80104723:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104725:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104728:	75 e6                	jne    80104710 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010472a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010472b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010472d:	5e                   	pop    %esi
8010472e:	5f                   	pop    %edi
8010472f:	5d                   	pop    %ebp
80104730:	c3                   	ret    
80104731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104738:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010473c:	0f b6 c2             	movzbl %dl,%eax
8010473f:	29 d8                	sub    %ebx,%eax
}
80104741:	5b                   	pop    %ebx
80104742:	5e                   	pop    %esi
80104743:	5f                   	pop    %edi
80104744:	5d                   	pop    %ebp
80104745:	c3                   	ret    
80104746:	8d 76 00             	lea    0x0(%esi),%esi
80104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104750 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
80104755:	8b 45 08             	mov    0x8(%ebp),%eax
80104758:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010475b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010475e:	89 c2                	mov    %eax,%edx
80104760:	eb 19                	jmp    8010477b <strncpy+0x2b>
80104762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104768:	83 c3 01             	add    $0x1,%ebx
8010476b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010476f:	83 c2 01             	add    $0x1,%edx
80104772:	84 c9                	test   %cl,%cl
80104774:	88 4a ff             	mov    %cl,-0x1(%edx)
80104777:	74 09                	je     80104782 <strncpy+0x32>
80104779:	89 f1                	mov    %esi,%ecx
8010477b:	85 c9                	test   %ecx,%ecx
8010477d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104780:	7f e6                	jg     80104768 <strncpy+0x18>
    ;
  while(n-- > 0)
80104782:	31 c9                	xor    %ecx,%ecx
80104784:	85 f6                	test   %esi,%esi
80104786:	7e 17                	jle    8010479f <strncpy+0x4f>
80104788:	90                   	nop
80104789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104790:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104794:	89 f3                	mov    %esi,%ebx
80104796:	83 c1 01             	add    $0x1,%ecx
80104799:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010479b:	85 db                	test   %ebx,%ebx
8010479d:	7f f1                	jg     80104790 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010479f:	5b                   	pop    %ebx
801047a0:	5e                   	pop    %esi
801047a1:	5d                   	pop    %ebp
801047a2:	c3                   	ret    
801047a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047b0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047b8:	8b 45 08             	mov    0x8(%ebp),%eax
801047bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801047be:	85 c9                	test   %ecx,%ecx
801047c0:	7e 26                	jle    801047e8 <safestrcpy+0x38>
801047c2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801047c6:	89 c1                	mov    %eax,%ecx
801047c8:	eb 17                	jmp    801047e1 <safestrcpy+0x31>
801047ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801047d0:	83 c2 01             	add    $0x1,%edx
801047d3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801047d7:	83 c1 01             	add    $0x1,%ecx
801047da:	84 db                	test   %bl,%bl
801047dc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801047df:	74 04                	je     801047e5 <safestrcpy+0x35>
801047e1:	39 f2                	cmp    %esi,%edx
801047e3:	75 eb                	jne    801047d0 <safestrcpy+0x20>
    ;
  *s = 0;
801047e5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801047e8:	5b                   	pop    %ebx
801047e9:	5e                   	pop    %esi
801047ea:	5d                   	pop    %ebp
801047eb:	c3                   	ret    
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <strlen>:

int
strlen(const char *s)
{
801047f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801047f1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801047f3:	89 e5                	mov    %esp,%ebp
801047f5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801047f8:	80 3a 00             	cmpb   $0x0,(%edx)
801047fb:	74 0c                	je     80104809 <strlen+0x19>
801047fd:	8d 76 00             	lea    0x0(%esi),%esi
80104800:	83 c0 01             	add    $0x1,%eax
80104803:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104807:	75 f7                	jne    80104800 <strlen+0x10>
    ;
  return n;
}
80104809:	5d                   	pop    %ebp
8010480a:	c3                   	ret    

8010480b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010480b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010480f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104813:	55                   	push   %ebp
  pushl %ebx
80104814:	53                   	push   %ebx
  pushl %esi
80104815:	56                   	push   %esi
  pushl %edi
80104816:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104817:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104819:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010481b:	5f                   	pop    %edi
  popl %esi
8010481c:	5e                   	pop    %esi
  popl %ebx
8010481d:	5b                   	pop    %ebx
  popl %ebp
8010481e:	5d                   	pop    %ebp
  ret
8010481f:	c3                   	ret    

80104820 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	53                   	push   %ebx
80104824:	83 ec 04             	sub    $0x4,%esp
80104827:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010482a:	e8 61 ef ff ff       	call   80103790 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010482f:	8b 00                	mov    (%eax),%eax
80104831:	39 d8                	cmp    %ebx,%eax
80104833:	76 1b                	jbe    80104850 <fetchint+0x30>
80104835:	8d 53 04             	lea    0x4(%ebx),%edx
80104838:	39 d0                	cmp    %edx,%eax
8010483a:	72 14                	jb     80104850 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010483c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010483f:	8b 13                	mov    (%ebx),%edx
80104841:	89 10                	mov    %edx,(%eax)
  return 0;
80104843:	31 c0                	xor    %eax,%eax
}
80104845:	83 c4 04             	add    $0x4,%esp
80104848:	5b                   	pop    %ebx
80104849:	5d                   	pop    %ebp
8010484a:	c3                   	ret    
8010484b:	90                   	nop
8010484c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104855:	eb ee                	jmp    80104845 <fetchint+0x25>
80104857:	89 f6                	mov    %esi,%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104860 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	53                   	push   %ebx
80104864:	83 ec 04             	sub    $0x4,%esp
80104867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010486a:	e8 21 ef ff ff       	call   80103790 <myproc>

  if(addr >= curproc->sz)
8010486f:	39 18                	cmp    %ebx,(%eax)
80104871:	76 29                	jbe    8010489c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104873:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104876:	89 da                	mov    %ebx,%edx
80104878:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010487a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010487c:	39 c3                	cmp    %eax,%ebx
8010487e:	73 1c                	jae    8010489c <fetchstr+0x3c>
    if(*s == 0)
80104880:	80 3b 00             	cmpb   $0x0,(%ebx)
80104883:	75 10                	jne    80104895 <fetchstr+0x35>
80104885:	eb 29                	jmp    801048b0 <fetchstr+0x50>
80104887:	89 f6                	mov    %esi,%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104890:	80 3a 00             	cmpb   $0x0,(%edx)
80104893:	74 1b                	je     801048b0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104895:	83 c2 01             	add    $0x1,%edx
80104898:	39 d0                	cmp    %edx,%eax
8010489a:	77 f4                	ja     80104890 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010489c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010489f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801048a4:	5b                   	pop    %ebx
801048a5:	5d                   	pop    %ebp
801048a6:	c3                   	ret    
801048a7:	89 f6                	mov    %esi,%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048b0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801048b3:	89 d0                	mov    %edx,%eax
801048b5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801048b7:	5b                   	pop    %ebx
801048b8:	5d                   	pop    %ebp
801048b9:	c3                   	ret    
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048c0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048c5:	e8 c6 ee ff ff       	call   80103790 <myproc>
801048ca:	8b 40 18             	mov    0x18(%eax),%eax
801048cd:	8b 55 08             	mov    0x8(%ebp),%edx
801048d0:	8b 40 44             	mov    0x44(%eax),%eax
801048d3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801048d6:	e8 b5 ee ff ff       	call   80103790 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048db:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048dd:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048e0:	39 c6                	cmp    %eax,%esi
801048e2:	73 1c                	jae    80104900 <argint+0x40>
801048e4:	8d 53 08             	lea    0x8(%ebx),%edx
801048e7:	39 d0                	cmp    %edx,%eax
801048e9:	72 15                	jb     80104900 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
801048eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ee:	8b 53 04             	mov    0x4(%ebx),%edx
801048f1:	89 10                	mov    %edx,(%eax)
  return 0;
801048f3:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
801048f5:	5b                   	pop    %ebx
801048f6:	5e                   	pop    %esi
801048f7:	5d                   	pop    %ebp
801048f8:	c3                   	ret    
801048f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104905:	eb ee                	jmp    801048f5 <argint+0x35>
80104907:	89 f6                	mov    %esi,%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104910 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
80104915:	83 ec 10             	sub    $0x10,%esp
80104918:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010491b:	e8 70 ee ff ff       	call   80103790 <myproc>
80104920:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104922:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104925:	83 ec 08             	sub    $0x8,%esp
80104928:	50                   	push   %eax
80104929:	ff 75 08             	pushl  0x8(%ebp)
8010492c:	e8 8f ff ff ff       	call   801048c0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104931:	c1 e8 1f             	shr    $0x1f,%eax
80104934:	83 c4 10             	add    $0x10,%esp
80104937:	84 c0                	test   %al,%al
80104939:	75 2d                	jne    80104968 <argptr+0x58>
8010493b:	89 d8                	mov    %ebx,%eax
8010493d:	c1 e8 1f             	shr    $0x1f,%eax
80104940:	84 c0                	test   %al,%al
80104942:	75 24                	jne    80104968 <argptr+0x58>
80104944:	8b 16                	mov    (%esi),%edx
80104946:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104949:	39 c2                	cmp    %eax,%edx
8010494b:	76 1b                	jbe    80104968 <argptr+0x58>
8010494d:	01 c3                	add    %eax,%ebx
8010494f:	39 da                	cmp    %ebx,%edx
80104951:	72 15                	jb     80104968 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104953:	8b 55 0c             	mov    0xc(%ebp),%edx
80104956:	89 02                	mov    %eax,(%edx)
  return 0;
80104958:	31 c0                	xor    %eax,%eax
}
8010495a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010495d:	5b                   	pop    %ebx
8010495e:	5e                   	pop    %esi
8010495f:	5d                   	pop    %ebp
80104960:	c3                   	ret    
80104961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010496d:	eb eb                	jmp    8010495a <argptr+0x4a>
8010496f:	90                   	nop

80104970 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104976:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104979:	50                   	push   %eax
8010497a:	ff 75 08             	pushl  0x8(%ebp)
8010497d:	e8 3e ff ff ff       	call   801048c0 <argint>
80104982:	83 c4 10             	add    $0x10,%esp
80104985:	85 c0                	test   %eax,%eax
80104987:	78 17                	js     801049a0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104989:	83 ec 08             	sub    $0x8,%esp
8010498c:	ff 75 0c             	pushl  0xc(%ebp)
8010498f:	ff 75 f4             	pushl  -0xc(%ebp)
80104992:	e8 c9 fe ff ff       	call   80104860 <fetchstr>
80104997:	83 c4 10             	add    $0x10,%esp
}
8010499a:	c9                   	leave  
8010499b:	c3                   	ret    
8010499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801049a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801049a5:	c9                   	leave  
801049a6:	c3                   	ret    
801049a7:	89 f6                	mov    %esi,%esi
801049a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049b0 <syscall>:
[SYS_chpr]    sys_chpr,
};

void
syscall(void)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
801049b5:	e8 d6 ed ff ff       	call   80103790 <myproc>

  num = curproc->tf->eax;
801049ba:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
801049bd:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801049bf:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801049c2:	8d 50 ff             	lea    -0x1(%eax),%edx
801049c5:	83 fa 16             	cmp    $0x16,%edx
801049c8:	77 1e                	ja     801049e8 <syscall+0x38>
801049ca:	8b 14 85 20 78 10 80 	mov    -0x7fef87e0(,%eax,4),%edx
801049d1:	85 d2                	test   %edx,%edx
801049d3:	74 13                	je     801049e8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801049d5:	ff d2                	call   *%edx
801049d7:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801049da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049dd:	5b                   	pop    %ebx
801049de:	5e                   	pop    %esi
801049df:	5d                   	pop    %ebp
801049e0:	c3                   	ret    
801049e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801049e8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801049e9:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801049ec:	50                   	push   %eax
801049ed:	ff 73 10             	pushl  0x10(%ebx)
801049f0:	68 f1 77 10 80       	push   $0x801077f1
801049f5:	e8 66 bc ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
801049fa:	8b 43 18             	mov    0x18(%ebx),%eax
801049fd:	83 c4 10             	add    $0x10,%esp
80104a00:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104a07:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a0a:	5b                   	pop    %ebx
80104a0b:	5e                   	pop    %esi
80104a0c:	5d                   	pop    %ebp
80104a0d:	c3                   	ret    
80104a0e:	66 90                	xchg   %ax,%ax

80104a10 <create>:
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	57                   	push   %edi
80104a14:	56                   	push   %esi
80104a15:	53                   	push   %ebx
80104a16:	8d 75 da             	lea    -0x26(%ebp),%esi
80104a19:	83 ec 44             	sub    $0x44,%esp
80104a1c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a1f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104a22:	56                   	push   %esi
80104a23:	50                   	push   %eax
80104a24:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a27:	89 4d bc             	mov    %ecx,-0x44(%ebp)
80104a2a:	e8 b1 d4 ff ff       	call   80101ee0 <nameiparent>
80104a2f:	83 c4 10             	add    $0x10,%esp
80104a32:	85 c0                	test   %eax,%eax
80104a34:	0f 84 f6 00 00 00    	je     80104b30 <create+0x120>
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	89 c7                	mov    %eax,%edi
80104a3f:	50                   	push   %eax
80104a40:	e8 2b cc ff ff       	call   80101670 <ilock>
80104a45:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104a48:	83 c4 0c             	add    $0xc,%esp
80104a4b:	50                   	push   %eax
80104a4c:	56                   	push   %esi
80104a4d:	57                   	push   %edi
80104a4e:	e8 4d d1 ff ff       	call   80101ba0 <dirlookup>
80104a53:	83 c4 10             	add    $0x10,%esp
80104a56:	85 c0                	test   %eax,%eax
80104a58:	89 c3                	mov    %eax,%ebx
80104a5a:	74 54                	je     80104ab0 <create+0xa0>
80104a5c:	83 ec 0c             	sub    $0xc,%esp
80104a5f:	57                   	push   %edi
80104a60:	e8 9b ce ff ff       	call   80101900 <iunlockput>
80104a65:	89 1c 24             	mov    %ebx,(%esp)
80104a68:	e8 03 cc ff ff       	call   80101670 <ilock>
80104a6d:	83 c4 10             	add    $0x10,%esp
80104a70:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104a75:	75 19                	jne    80104a90 <create+0x80>
80104a77:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104a7c:	89 d8                	mov    %ebx,%eax
80104a7e:	75 10                	jne    80104a90 <create+0x80>
80104a80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a83:	5b                   	pop    %ebx
80104a84:	5e                   	pop    %esi
80104a85:	5f                   	pop    %edi
80104a86:	5d                   	pop    %ebp
80104a87:	c3                   	ret    
80104a88:	90                   	nop
80104a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a90:	83 ec 0c             	sub    $0xc,%esp
80104a93:	53                   	push   %ebx
80104a94:	e8 67 ce ff ff       	call   80101900 <iunlockput>
80104a99:	83 c4 10             	add    $0x10,%esp
80104a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a9f:	31 c0                	xor    %eax,%eax
80104aa1:	5b                   	pop    %ebx
80104aa2:	5e                   	pop    %esi
80104aa3:	5f                   	pop    %edi
80104aa4:	5d                   	pop    %ebp
80104aa5:	c3                   	ret    
80104aa6:	8d 76 00             	lea    0x0(%esi),%esi
80104aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ab0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ab4:	83 ec 08             	sub    $0x8,%esp
80104ab7:	50                   	push   %eax
80104ab8:	ff 37                	pushl  (%edi)
80104aba:	e8 41 ca ff ff       	call   80101500 <ialloc>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	85 c0                	test   %eax,%eax
80104ac4:	89 c3                	mov    %eax,%ebx
80104ac6:	0f 84 cc 00 00 00    	je     80104b98 <create+0x188>
80104acc:	83 ec 0c             	sub    $0xc,%esp
80104acf:	50                   	push   %eax
80104ad0:	e8 9b cb ff ff       	call   80101670 <ilock>
80104ad5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104ad9:	66 89 43 52          	mov    %ax,0x52(%ebx)
80104add:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ae1:	66 89 43 54          	mov    %ax,0x54(%ebx)
80104ae5:	b8 01 00 00 00       	mov    $0x1,%eax
80104aea:	66 89 43 56          	mov    %ax,0x56(%ebx)
80104aee:	89 1c 24             	mov    %ebx,(%esp)
80104af1:	e8 ca ca ff ff       	call   801015c0 <iupdate>
80104af6:	83 c4 10             	add    $0x10,%esp
80104af9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104afe:	74 40                	je     80104b40 <create+0x130>
80104b00:	83 ec 04             	sub    $0x4,%esp
80104b03:	ff 73 04             	pushl  0x4(%ebx)
80104b06:	56                   	push   %esi
80104b07:	57                   	push   %edi
80104b08:	e8 f3 d2 ff ff       	call   80101e00 <dirlink>
80104b0d:	83 c4 10             	add    $0x10,%esp
80104b10:	85 c0                	test   %eax,%eax
80104b12:	78 77                	js     80104b8b <create+0x17b>
80104b14:	83 ec 0c             	sub    $0xc,%esp
80104b17:	57                   	push   %edi
80104b18:	e8 e3 cd ff ff       	call   80101900 <iunlockput>
80104b1d:	83 c4 10             	add    $0x10,%esp
80104b20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b23:	89 d8                	mov    %ebx,%eax
80104b25:	5b                   	pop    %ebx
80104b26:	5e                   	pop    %esi
80104b27:	5f                   	pop    %edi
80104b28:	5d                   	pop    %ebp
80104b29:	c3                   	ret    
80104b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b30:	31 c0                	xor    %eax,%eax
80104b32:	e9 49 ff ff ff       	jmp    80104a80 <create+0x70>
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b40:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
80104b45:	83 ec 0c             	sub    $0xc,%esp
80104b48:	57                   	push   %edi
80104b49:	e8 72 ca ff ff       	call   801015c0 <iupdate>
80104b4e:	83 c4 0c             	add    $0xc,%esp
80104b51:	ff 73 04             	pushl  0x4(%ebx)
80104b54:	68 9c 78 10 80       	push   $0x8010789c
80104b59:	53                   	push   %ebx
80104b5a:	e8 a1 d2 ff ff       	call   80101e00 <dirlink>
80104b5f:	83 c4 10             	add    $0x10,%esp
80104b62:	85 c0                	test   %eax,%eax
80104b64:	78 18                	js     80104b7e <create+0x16e>
80104b66:	83 ec 04             	sub    $0x4,%esp
80104b69:	ff 77 04             	pushl  0x4(%edi)
80104b6c:	68 9b 78 10 80       	push   $0x8010789b
80104b71:	53                   	push   %ebx
80104b72:	e8 89 d2 ff ff       	call   80101e00 <dirlink>
80104b77:	83 c4 10             	add    $0x10,%esp
80104b7a:	85 c0                	test   %eax,%eax
80104b7c:	79 82                	jns    80104b00 <create+0xf0>
80104b7e:	83 ec 0c             	sub    $0xc,%esp
80104b81:	68 8f 78 10 80       	push   $0x8010788f
80104b86:	e8 e5 b7 ff ff       	call   80100370 <panic>
80104b8b:	83 ec 0c             	sub    $0xc,%esp
80104b8e:	68 9e 78 10 80       	push   $0x8010789e
80104b93:	e8 d8 b7 ff ff       	call   80100370 <panic>
80104b98:	83 ec 0c             	sub    $0xc,%esp
80104b9b:	68 80 78 10 80       	push   $0x80107880
80104ba0:	e8 cb b7 ff ff       	call   80100370 <panic>
80104ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bb0 <argfd.constprop.0>:
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	53                   	push   %ebx
80104bb5:	89 c6                	mov    %eax,%esi
80104bb7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bba:	89 d3                	mov    %edx,%ebx
80104bbc:	83 ec 18             	sub    $0x18,%esp
80104bbf:	50                   	push   %eax
80104bc0:	6a 00                	push   $0x0
80104bc2:	e8 f9 fc ff ff       	call   801048c0 <argint>
80104bc7:	83 c4 10             	add    $0x10,%esp
80104bca:	85 c0                	test   %eax,%eax
80104bcc:	78 32                	js     80104c00 <argfd.constprop.0+0x50>
80104bce:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104bd2:	77 2c                	ja     80104c00 <argfd.constprop.0+0x50>
80104bd4:	e8 b7 eb ff ff       	call   80103790 <myproc>
80104bd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bdc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104be0:	85 c0                	test   %eax,%eax
80104be2:	74 1c                	je     80104c00 <argfd.constprop.0+0x50>
80104be4:	85 f6                	test   %esi,%esi
80104be6:	74 02                	je     80104bea <argfd.constprop.0+0x3a>
80104be8:	89 16                	mov    %edx,(%esi)
80104bea:	85 db                	test   %ebx,%ebx
80104bec:	74 22                	je     80104c10 <argfd.constprop.0+0x60>
80104bee:	89 03                	mov    %eax,(%ebx)
80104bf0:	31 c0                	xor    %eax,%eax
80104bf2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bf5:	5b                   	pop    %ebx
80104bf6:	5e                   	pop    %esi
80104bf7:	5d                   	pop    %ebp
80104bf8:	c3                   	ret    
80104bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c00:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c08:	5b                   	pop    %ebx
80104c09:	5e                   	pop    %esi
80104c0a:	5d                   	pop    %ebp
80104c0b:	c3                   	ret    
80104c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c10:	31 c0                	xor    %eax,%eax
80104c12:	eb de                	jmp    80104bf2 <argfd.constprop.0+0x42>
80104c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c20 <sys_dup>:
80104c20:	55                   	push   %ebp
80104c21:	31 c0                	xor    %eax,%eax
80104c23:	89 e5                	mov    %esp,%ebp
80104c25:	56                   	push   %esi
80104c26:	53                   	push   %ebx
80104c27:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104c2a:	83 ec 10             	sub    $0x10,%esp
80104c2d:	e8 7e ff ff ff       	call   80104bb0 <argfd.constprop.0>
80104c32:	85 c0                	test   %eax,%eax
80104c34:	78 1a                	js     80104c50 <sys_dup+0x30>
80104c36:	31 db                	xor    %ebx,%ebx
80104c38:	8b 75 f4             	mov    -0xc(%ebp),%esi
80104c3b:	e8 50 eb ff ff       	call   80103790 <myproc>
80104c40:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104c44:	85 d2                	test   %edx,%edx
80104c46:	74 18                	je     80104c60 <sys_dup+0x40>
80104c48:	83 c3 01             	add    $0x1,%ebx
80104c4b:	83 fb 10             	cmp    $0x10,%ebx
80104c4e:	75 f0                	jne    80104c40 <sys_dup+0x20>
80104c50:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c58:	5b                   	pop    %ebx
80104c59:	5e                   	pop    %esi
80104c5a:	5d                   	pop    %ebp
80104c5b:	c3                   	ret    
80104c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c60:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80104c64:	83 ec 0c             	sub    $0xc,%esp
80104c67:	ff 75 f4             	pushl  -0xc(%ebp)
80104c6a:	e8 71 c1 ff ff       	call   80100de0 <filedup>
80104c6f:	83 c4 10             	add    $0x10,%esp
80104c72:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c75:	89 d8                	mov    %ebx,%eax
80104c77:	5b                   	pop    %ebx
80104c78:	5e                   	pop    %esi
80104c79:	5d                   	pop    %ebp
80104c7a:	c3                   	ret    
80104c7b:	90                   	nop
80104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c80 <sys_read>:
80104c80:	55                   	push   %ebp
80104c81:	31 c0                	xor    %eax,%eax
80104c83:	89 e5                	mov    %esp,%ebp
80104c85:	83 ec 18             	sub    $0x18,%esp
80104c88:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c8b:	e8 20 ff ff ff       	call   80104bb0 <argfd.constprop.0>
80104c90:	85 c0                	test   %eax,%eax
80104c92:	78 4c                	js     80104ce0 <sys_read+0x60>
80104c94:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c97:	83 ec 08             	sub    $0x8,%esp
80104c9a:	50                   	push   %eax
80104c9b:	6a 02                	push   $0x2
80104c9d:	e8 1e fc ff ff       	call   801048c0 <argint>
80104ca2:	83 c4 10             	add    $0x10,%esp
80104ca5:	85 c0                	test   %eax,%eax
80104ca7:	78 37                	js     80104ce0 <sys_read+0x60>
80104ca9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cac:	83 ec 04             	sub    $0x4,%esp
80104caf:	ff 75 f0             	pushl  -0x10(%ebp)
80104cb2:	50                   	push   %eax
80104cb3:	6a 01                	push   $0x1
80104cb5:	e8 56 fc ff ff       	call   80104910 <argptr>
80104cba:	83 c4 10             	add    $0x10,%esp
80104cbd:	85 c0                	test   %eax,%eax
80104cbf:	78 1f                	js     80104ce0 <sys_read+0x60>
80104cc1:	83 ec 04             	sub    $0x4,%esp
80104cc4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cca:	ff 75 ec             	pushl  -0x14(%ebp)
80104ccd:	e8 7e c2 ff ff       	call   80100f50 <fileread>
80104cd2:	83 c4 10             	add    $0x10,%esp
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cf0 <sys_write>:
80104cf0:	55                   	push   %ebp
80104cf1:	31 c0                	xor    %eax,%eax
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	83 ec 18             	sub    $0x18,%esp
80104cf8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cfb:	e8 b0 fe ff ff       	call   80104bb0 <argfd.constprop.0>
80104d00:	85 c0                	test   %eax,%eax
80104d02:	78 4c                	js     80104d50 <sys_write+0x60>
80104d04:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d07:	83 ec 08             	sub    $0x8,%esp
80104d0a:	50                   	push   %eax
80104d0b:	6a 02                	push   $0x2
80104d0d:	e8 ae fb ff ff       	call   801048c0 <argint>
80104d12:	83 c4 10             	add    $0x10,%esp
80104d15:	85 c0                	test   %eax,%eax
80104d17:	78 37                	js     80104d50 <sys_write+0x60>
80104d19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d1c:	83 ec 04             	sub    $0x4,%esp
80104d1f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d22:	50                   	push   %eax
80104d23:	6a 01                	push   $0x1
80104d25:	e8 e6 fb ff ff       	call   80104910 <argptr>
80104d2a:	83 c4 10             	add    $0x10,%esp
80104d2d:	85 c0                	test   %eax,%eax
80104d2f:	78 1f                	js     80104d50 <sys_write+0x60>
80104d31:	83 ec 04             	sub    $0x4,%esp
80104d34:	ff 75 f0             	pushl  -0x10(%ebp)
80104d37:	ff 75 f4             	pushl  -0xc(%ebp)
80104d3a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d3d:	e8 9e c2 ff ff       	call   80100fe0 <filewrite>
80104d42:	83 c4 10             	add    $0x10,%esp
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d55:	c9                   	leave  
80104d56:	c3                   	ret    
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <sys_close>:
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	83 ec 18             	sub    $0x18,%esp
80104d66:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d69:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d6c:	e8 3f fe ff ff       	call   80104bb0 <argfd.constprop.0>
80104d71:	85 c0                	test   %eax,%eax
80104d73:	78 2b                	js     80104da0 <sys_close+0x40>
80104d75:	e8 16 ea ff ff       	call   80103790 <myproc>
80104d7a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d7d:	83 ec 0c             	sub    $0xc,%esp
80104d80:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d87:	00 
80104d88:	ff 75 f4             	pushl  -0xc(%ebp)
80104d8b:	e8 a0 c0 ff ff       	call   80100e30 <fileclose>
80104d90:	83 c4 10             	add    $0x10,%esp
80104d93:	31 c0                	xor    %eax,%eax
80104d95:	c9                   	leave  
80104d96:	c3                   	ret    
80104d97:	89 f6                	mov    %esi,%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104da5:	c9                   	leave  
80104da6:	c3                   	ret    
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104db0 <sys_fstat>:
80104db0:	55                   	push   %ebp
80104db1:	31 c0                	xor    %eax,%eax
80104db3:	89 e5                	mov    %esp,%ebp
80104db5:	83 ec 18             	sub    $0x18,%esp
80104db8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104dbb:	e8 f0 fd ff ff       	call   80104bb0 <argfd.constprop.0>
80104dc0:	85 c0                	test   %eax,%eax
80104dc2:	78 2c                	js     80104df0 <sys_fstat+0x40>
80104dc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dc7:	83 ec 04             	sub    $0x4,%esp
80104dca:	6a 14                	push   $0x14
80104dcc:	50                   	push   %eax
80104dcd:	6a 01                	push   $0x1
80104dcf:	e8 3c fb ff ff       	call   80104910 <argptr>
80104dd4:	83 c4 10             	add    $0x10,%esp
80104dd7:	85 c0                	test   %eax,%eax
80104dd9:	78 15                	js     80104df0 <sys_fstat+0x40>
80104ddb:	83 ec 08             	sub    $0x8,%esp
80104dde:	ff 75 f4             	pushl  -0xc(%ebp)
80104de1:	ff 75 f0             	pushl  -0x10(%ebp)
80104de4:	e8 17 c1 ff ff       	call   80100f00 <filestat>
80104de9:	83 c4 10             	add    $0x10,%esp
80104dec:	c9                   	leave  
80104ded:	c3                   	ret    
80104dee:	66 90                	xchg   %ax,%ax
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_link>:
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	56                   	push   %esi
80104e05:	53                   	push   %ebx
80104e06:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104e09:	83 ec 34             	sub    $0x34,%esp
80104e0c:	50                   	push   %eax
80104e0d:	6a 00                	push   $0x0
80104e0f:	e8 5c fb ff ff       	call   80104970 <argstr>
80104e14:	83 c4 10             	add    $0x10,%esp
80104e17:	85 c0                	test   %eax,%eax
80104e19:	0f 88 fb 00 00 00    	js     80104f1a <sys_link+0x11a>
80104e1f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e22:	83 ec 08             	sub    $0x8,%esp
80104e25:	50                   	push   %eax
80104e26:	6a 01                	push   $0x1
80104e28:	e8 43 fb ff ff       	call   80104970 <argstr>
80104e2d:	83 c4 10             	add    $0x10,%esp
80104e30:	85 c0                	test   %eax,%eax
80104e32:	0f 88 e2 00 00 00    	js     80104f1a <sys_link+0x11a>
80104e38:	e8 13 dd ff ff       	call   80102b50 <begin_op>
80104e3d:	83 ec 0c             	sub    $0xc,%esp
80104e40:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e43:	e8 78 d0 ff ff       	call   80101ec0 <namei>
80104e48:	83 c4 10             	add    $0x10,%esp
80104e4b:	85 c0                	test   %eax,%eax
80104e4d:	89 c3                	mov    %eax,%ebx
80104e4f:	0f 84 f3 00 00 00    	je     80104f48 <sys_link+0x148>
80104e55:	83 ec 0c             	sub    $0xc,%esp
80104e58:	50                   	push   %eax
80104e59:	e8 12 c8 ff ff       	call   80101670 <ilock>
80104e5e:	83 c4 10             	add    $0x10,%esp
80104e61:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e66:	0f 84 c4 00 00 00    	je     80104f30 <sys_link+0x130>
80104e6c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104e71:	83 ec 0c             	sub    $0xc,%esp
80104e74:	8d 7d da             	lea    -0x26(%ebp),%edi
80104e77:	53                   	push   %ebx
80104e78:	e8 43 c7 ff ff       	call   801015c0 <iupdate>
80104e7d:	89 1c 24             	mov    %ebx,(%esp)
80104e80:	e8 cb c8 ff ff       	call   80101750 <iunlock>
80104e85:	58                   	pop    %eax
80104e86:	5a                   	pop    %edx
80104e87:	57                   	push   %edi
80104e88:	ff 75 d0             	pushl  -0x30(%ebp)
80104e8b:	e8 50 d0 ff ff       	call   80101ee0 <nameiparent>
80104e90:	83 c4 10             	add    $0x10,%esp
80104e93:	85 c0                	test   %eax,%eax
80104e95:	89 c6                	mov    %eax,%esi
80104e97:	74 5b                	je     80104ef4 <sys_link+0xf4>
80104e99:	83 ec 0c             	sub    $0xc,%esp
80104e9c:	50                   	push   %eax
80104e9d:	e8 ce c7 ff ff       	call   80101670 <ilock>
80104ea2:	83 c4 10             	add    $0x10,%esp
80104ea5:	8b 03                	mov    (%ebx),%eax
80104ea7:	39 06                	cmp    %eax,(%esi)
80104ea9:	75 3d                	jne    80104ee8 <sys_link+0xe8>
80104eab:	83 ec 04             	sub    $0x4,%esp
80104eae:	ff 73 04             	pushl  0x4(%ebx)
80104eb1:	57                   	push   %edi
80104eb2:	56                   	push   %esi
80104eb3:	e8 48 cf ff ff       	call   80101e00 <dirlink>
80104eb8:	83 c4 10             	add    $0x10,%esp
80104ebb:	85 c0                	test   %eax,%eax
80104ebd:	78 29                	js     80104ee8 <sys_link+0xe8>
80104ebf:	83 ec 0c             	sub    $0xc,%esp
80104ec2:	56                   	push   %esi
80104ec3:	e8 38 ca ff ff       	call   80101900 <iunlockput>
80104ec8:	89 1c 24             	mov    %ebx,(%esp)
80104ecb:	e8 d0 c8 ff ff       	call   801017a0 <iput>
80104ed0:	e8 eb dc ff ff       	call   80102bc0 <end_op>
80104ed5:	83 c4 10             	add    $0x10,%esp
80104ed8:	31 c0                	xor    %eax,%eax
80104eda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104edd:	5b                   	pop    %ebx
80104ede:	5e                   	pop    %esi
80104edf:	5f                   	pop    %edi
80104ee0:	5d                   	pop    %ebp
80104ee1:	c3                   	ret    
80104ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ee8:	83 ec 0c             	sub    $0xc,%esp
80104eeb:	56                   	push   %esi
80104eec:	e8 0f ca ff ff       	call   80101900 <iunlockput>
80104ef1:	83 c4 10             	add    $0x10,%esp
80104ef4:	83 ec 0c             	sub    $0xc,%esp
80104ef7:	53                   	push   %ebx
80104ef8:	e8 73 c7 ff ff       	call   80101670 <ilock>
80104efd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80104f02:	89 1c 24             	mov    %ebx,(%esp)
80104f05:	e8 b6 c6 ff ff       	call   801015c0 <iupdate>
80104f0a:	89 1c 24             	mov    %ebx,(%esp)
80104f0d:	e8 ee c9 ff ff       	call   80101900 <iunlockput>
80104f12:	e8 a9 dc ff ff       	call   80102bc0 <end_op>
80104f17:	83 c4 10             	add    $0x10,%esp
80104f1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f22:	5b                   	pop    %ebx
80104f23:	5e                   	pop    %esi
80104f24:	5f                   	pop    %edi
80104f25:	5d                   	pop    %ebp
80104f26:	c3                   	ret    
80104f27:	89 f6                	mov    %esi,%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104f30:	83 ec 0c             	sub    $0xc,%esp
80104f33:	53                   	push   %ebx
80104f34:	e8 c7 c9 ff ff       	call   80101900 <iunlockput>
80104f39:	e8 82 dc ff ff       	call   80102bc0 <end_op>
80104f3e:	83 c4 10             	add    $0x10,%esp
80104f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f46:	eb 92                	jmp    80104eda <sys_link+0xda>
80104f48:	e8 73 dc ff ff       	call   80102bc0 <end_op>
80104f4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f52:	eb 86                	jmp    80104eda <sys_link+0xda>
80104f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f60 <sys_unlink>:
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	57                   	push   %edi
80104f64:	56                   	push   %esi
80104f65:	53                   	push   %ebx
80104f66:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104f69:	83 ec 54             	sub    $0x54,%esp
80104f6c:	50                   	push   %eax
80104f6d:	6a 00                	push   $0x0
80104f6f:	e8 fc f9 ff ff       	call   80104970 <argstr>
80104f74:	83 c4 10             	add    $0x10,%esp
80104f77:	85 c0                	test   %eax,%eax
80104f79:	0f 88 82 01 00 00    	js     80105101 <sys_unlink+0x1a1>
80104f7f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104f82:	e8 c9 db ff ff       	call   80102b50 <begin_op>
80104f87:	83 ec 08             	sub    $0x8,%esp
80104f8a:	53                   	push   %ebx
80104f8b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f8e:	e8 4d cf ff ff       	call   80101ee0 <nameiparent>
80104f93:	83 c4 10             	add    $0x10,%esp
80104f96:	85 c0                	test   %eax,%eax
80104f98:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104f9b:	0f 84 6a 01 00 00    	je     8010510b <sys_unlink+0x1ab>
80104fa1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104fa4:	83 ec 0c             	sub    $0xc,%esp
80104fa7:	56                   	push   %esi
80104fa8:	e8 c3 c6 ff ff       	call   80101670 <ilock>
80104fad:	58                   	pop    %eax
80104fae:	5a                   	pop    %edx
80104faf:	68 9c 78 10 80       	push   $0x8010789c
80104fb4:	53                   	push   %ebx
80104fb5:	e8 c6 cb ff ff       	call   80101b80 <namecmp>
80104fba:	83 c4 10             	add    $0x10,%esp
80104fbd:	85 c0                	test   %eax,%eax
80104fbf:	0f 84 fc 00 00 00    	je     801050c1 <sys_unlink+0x161>
80104fc5:	83 ec 08             	sub    $0x8,%esp
80104fc8:	68 9b 78 10 80       	push   $0x8010789b
80104fcd:	53                   	push   %ebx
80104fce:	e8 ad cb ff ff       	call   80101b80 <namecmp>
80104fd3:	83 c4 10             	add    $0x10,%esp
80104fd6:	85 c0                	test   %eax,%eax
80104fd8:	0f 84 e3 00 00 00    	je     801050c1 <sys_unlink+0x161>
80104fde:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104fe1:	83 ec 04             	sub    $0x4,%esp
80104fe4:	50                   	push   %eax
80104fe5:	53                   	push   %ebx
80104fe6:	56                   	push   %esi
80104fe7:	e8 b4 cb ff ff       	call   80101ba0 <dirlookup>
80104fec:	83 c4 10             	add    $0x10,%esp
80104fef:	85 c0                	test   %eax,%eax
80104ff1:	89 c3                	mov    %eax,%ebx
80104ff3:	0f 84 c8 00 00 00    	je     801050c1 <sys_unlink+0x161>
80104ff9:	83 ec 0c             	sub    $0xc,%esp
80104ffc:	50                   	push   %eax
80104ffd:	e8 6e c6 ff ff       	call   80101670 <ilock>
80105002:	83 c4 10             	add    $0x10,%esp
80105005:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010500a:	0f 8e 24 01 00 00    	jle    80105134 <sys_unlink+0x1d4>
80105010:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105015:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105018:	74 66                	je     80105080 <sys_unlink+0x120>
8010501a:	83 ec 04             	sub    $0x4,%esp
8010501d:	6a 10                	push   $0x10
8010501f:	6a 00                	push   $0x0
80105021:	56                   	push   %esi
80105022:	e8 89 f5 ff ff       	call   801045b0 <memset>
80105027:	6a 10                	push   $0x10
80105029:	ff 75 c4             	pushl  -0x3c(%ebp)
8010502c:	56                   	push   %esi
8010502d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105030:	e8 1b ca ff ff       	call   80101a50 <writei>
80105035:	83 c4 20             	add    $0x20,%esp
80105038:	83 f8 10             	cmp    $0x10,%eax
8010503b:	0f 85 e6 00 00 00    	jne    80105127 <sys_unlink+0x1c7>
80105041:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105046:	0f 84 9c 00 00 00    	je     801050e8 <sys_unlink+0x188>
8010504c:	83 ec 0c             	sub    $0xc,%esp
8010504f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105052:	e8 a9 c8 ff ff       	call   80101900 <iunlockput>
80105057:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010505c:	89 1c 24             	mov    %ebx,(%esp)
8010505f:	e8 5c c5 ff ff       	call   801015c0 <iupdate>
80105064:	89 1c 24             	mov    %ebx,(%esp)
80105067:	e8 94 c8 ff ff       	call   80101900 <iunlockput>
8010506c:	e8 4f db ff ff       	call   80102bc0 <end_op>
80105071:	83 c4 10             	add    $0x10,%esp
80105074:	31 c0                	xor    %eax,%eax
80105076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105079:	5b                   	pop    %ebx
8010507a:	5e                   	pop    %esi
8010507b:	5f                   	pop    %edi
8010507c:	5d                   	pop    %ebp
8010507d:	c3                   	ret    
8010507e:	66 90                	xchg   %ax,%ax
80105080:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105084:	76 94                	jbe    8010501a <sys_unlink+0xba>
80105086:	bf 20 00 00 00       	mov    $0x20,%edi
8010508b:	eb 0f                	jmp    8010509c <sys_unlink+0x13c>
8010508d:	8d 76 00             	lea    0x0(%esi),%esi
80105090:	83 c7 10             	add    $0x10,%edi
80105093:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105096:	0f 83 7e ff ff ff    	jae    8010501a <sys_unlink+0xba>
8010509c:	6a 10                	push   $0x10
8010509e:	57                   	push   %edi
8010509f:	56                   	push   %esi
801050a0:	53                   	push   %ebx
801050a1:	e8 aa c8 ff ff       	call   80101950 <readi>
801050a6:	83 c4 10             	add    $0x10,%esp
801050a9:	83 f8 10             	cmp    $0x10,%eax
801050ac:	75 6c                	jne    8010511a <sys_unlink+0x1ba>
801050ae:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050b3:	74 db                	je     80105090 <sys_unlink+0x130>
801050b5:	83 ec 0c             	sub    $0xc,%esp
801050b8:	53                   	push   %ebx
801050b9:	e8 42 c8 ff ff       	call   80101900 <iunlockput>
801050be:	83 c4 10             	add    $0x10,%esp
801050c1:	83 ec 0c             	sub    $0xc,%esp
801050c4:	ff 75 b4             	pushl  -0x4c(%ebp)
801050c7:	e8 34 c8 ff ff       	call   80101900 <iunlockput>
801050cc:	e8 ef da ff ff       	call   80102bc0 <end_op>
801050d1:	83 c4 10             	add    $0x10,%esp
801050d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050dc:	5b                   	pop    %ebx
801050dd:	5e                   	pop    %esi
801050de:	5f                   	pop    %edi
801050df:	5d                   	pop    %ebp
801050e0:	c3                   	ret    
801050e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050e8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801050eb:	83 ec 0c             	sub    $0xc,%esp
801050ee:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
801050f3:	50                   	push   %eax
801050f4:	e8 c7 c4 ff ff       	call   801015c0 <iupdate>
801050f9:	83 c4 10             	add    $0x10,%esp
801050fc:	e9 4b ff ff ff       	jmp    8010504c <sys_unlink+0xec>
80105101:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105106:	e9 6b ff ff ff       	jmp    80105076 <sys_unlink+0x116>
8010510b:	e8 b0 da ff ff       	call   80102bc0 <end_op>
80105110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105115:	e9 5c ff ff ff       	jmp    80105076 <sys_unlink+0x116>
8010511a:	83 ec 0c             	sub    $0xc,%esp
8010511d:	68 c0 78 10 80       	push   $0x801078c0
80105122:	e8 49 b2 ff ff       	call   80100370 <panic>
80105127:	83 ec 0c             	sub    $0xc,%esp
8010512a:	68 d2 78 10 80       	push   $0x801078d2
8010512f:	e8 3c b2 ff ff       	call   80100370 <panic>
80105134:	83 ec 0c             	sub    $0xc,%esp
80105137:	68 ae 78 10 80       	push   $0x801078ae
8010513c:	e8 2f b2 ff ff       	call   80100370 <panic>
80105141:	eb 0d                	jmp    80105150 <sys_open>
80105143:	90                   	nop
80105144:	90                   	nop
80105145:	90                   	nop
80105146:	90                   	nop
80105147:	90                   	nop
80105148:	90                   	nop
80105149:	90                   	nop
8010514a:	90                   	nop
8010514b:	90                   	nop
8010514c:	90                   	nop
8010514d:	90                   	nop
8010514e:	90                   	nop
8010514f:	90                   	nop

80105150 <sys_open>:
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	57                   	push   %edi
80105154:	56                   	push   %esi
80105155:	53                   	push   %ebx
80105156:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105159:	83 ec 24             	sub    $0x24,%esp
8010515c:	50                   	push   %eax
8010515d:	6a 00                	push   $0x0
8010515f:	e8 0c f8 ff ff       	call   80104970 <argstr>
80105164:	83 c4 10             	add    $0x10,%esp
80105167:	85 c0                	test   %eax,%eax
80105169:	0f 88 9e 00 00 00    	js     8010520d <sys_open+0xbd>
8010516f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105172:	83 ec 08             	sub    $0x8,%esp
80105175:	50                   	push   %eax
80105176:	6a 01                	push   $0x1
80105178:	e8 43 f7 ff ff       	call   801048c0 <argint>
8010517d:	83 c4 10             	add    $0x10,%esp
80105180:	85 c0                	test   %eax,%eax
80105182:	0f 88 85 00 00 00    	js     8010520d <sys_open+0xbd>
80105188:	e8 c3 d9 ff ff       	call   80102b50 <begin_op>
8010518d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105191:	0f 85 89 00 00 00    	jne    80105220 <sys_open+0xd0>
80105197:	83 ec 0c             	sub    $0xc,%esp
8010519a:	ff 75 e0             	pushl  -0x20(%ebp)
8010519d:	e8 1e cd ff ff       	call   80101ec0 <namei>
801051a2:	83 c4 10             	add    $0x10,%esp
801051a5:	85 c0                	test   %eax,%eax
801051a7:	89 c6                	mov    %eax,%esi
801051a9:	0f 84 8e 00 00 00    	je     8010523d <sys_open+0xed>
801051af:	83 ec 0c             	sub    $0xc,%esp
801051b2:	50                   	push   %eax
801051b3:	e8 b8 c4 ff ff       	call   80101670 <ilock>
801051b8:	83 c4 10             	add    $0x10,%esp
801051bb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801051c0:	0f 84 d2 00 00 00    	je     80105298 <sys_open+0x148>
801051c6:	e8 a5 bb ff ff       	call   80100d70 <filealloc>
801051cb:	85 c0                	test   %eax,%eax
801051cd:	89 c7                	mov    %eax,%edi
801051cf:	74 2b                	je     801051fc <sys_open+0xac>
801051d1:	31 db                	xor    %ebx,%ebx
801051d3:	e8 b8 e5 ff ff       	call   80103790 <myproc>
801051d8:	90                   	nop
801051d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801051e4:	85 d2                	test   %edx,%edx
801051e6:	74 68                	je     80105250 <sys_open+0x100>
801051e8:	83 c3 01             	add    $0x1,%ebx
801051eb:	83 fb 10             	cmp    $0x10,%ebx
801051ee:	75 f0                	jne    801051e0 <sys_open+0x90>
801051f0:	83 ec 0c             	sub    $0xc,%esp
801051f3:	57                   	push   %edi
801051f4:	e8 37 bc ff ff       	call   80100e30 <fileclose>
801051f9:	83 c4 10             	add    $0x10,%esp
801051fc:	83 ec 0c             	sub    $0xc,%esp
801051ff:	56                   	push   %esi
80105200:	e8 fb c6 ff ff       	call   80101900 <iunlockput>
80105205:	e8 b6 d9 ff ff       	call   80102bc0 <end_op>
8010520a:	83 c4 10             	add    $0x10,%esp
8010520d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105215:	5b                   	pop    %ebx
80105216:	5e                   	pop    %esi
80105217:	5f                   	pop    %edi
80105218:	5d                   	pop    %ebp
80105219:	c3                   	ret    
8010521a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105220:	83 ec 0c             	sub    $0xc,%esp
80105223:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105226:	31 c9                	xor    %ecx,%ecx
80105228:	6a 00                	push   $0x0
8010522a:	ba 02 00 00 00       	mov    $0x2,%edx
8010522f:	e8 dc f7 ff ff       	call   80104a10 <create>
80105234:	83 c4 10             	add    $0x10,%esp
80105237:	85 c0                	test   %eax,%eax
80105239:	89 c6                	mov    %eax,%esi
8010523b:	75 89                	jne    801051c6 <sys_open+0x76>
8010523d:	e8 7e d9 ff ff       	call   80102bc0 <end_op>
80105242:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105247:	eb 43                	jmp    8010528c <sys_open+0x13c>
80105249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105250:	83 ec 0c             	sub    $0xc,%esp
80105253:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80105257:	56                   	push   %esi
80105258:	e8 f3 c4 ff ff       	call   80101750 <iunlock>
8010525d:	e8 5e d9 ff ff       	call   80102bc0 <end_op>
80105262:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105268:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010526b:	83 c4 10             	add    $0x10,%esp
8010526e:	89 77 10             	mov    %esi,0x10(%edi)
80105271:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80105278:	89 d0                	mov    %edx,%eax
8010527a:	83 e0 01             	and    $0x1,%eax
8010527d:	83 f0 01             	xor    $0x1,%eax
80105280:	83 e2 03             	and    $0x3,%edx
80105283:	88 47 08             	mov    %al,0x8(%edi)
80105286:	0f 95 47 09          	setne  0x9(%edi)
8010528a:	89 d8                	mov    %ebx,%eax
8010528c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010528f:	5b                   	pop    %ebx
80105290:	5e                   	pop    %esi
80105291:	5f                   	pop    %edi
80105292:	5d                   	pop    %ebp
80105293:	c3                   	ret    
80105294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105298:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010529b:	85 c9                	test   %ecx,%ecx
8010529d:	0f 84 23 ff ff ff    	je     801051c6 <sys_open+0x76>
801052a3:	e9 54 ff ff ff       	jmp    801051fc <sys_open+0xac>
801052a8:	90                   	nop
801052a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801052b0 <sys_mkdir>:
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	83 ec 18             	sub    $0x18,%esp
801052b6:	e8 95 d8 ff ff       	call   80102b50 <begin_op>
801052bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052be:	83 ec 08             	sub    $0x8,%esp
801052c1:	50                   	push   %eax
801052c2:	6a 00                	push   $0x0
801052c4:	e8 a7 f6 ff ff       	call   80104970 <argstr>
801052c9:	83 c4 10             	add    $0x10,%esp
801052cc:	85 c0                	test   %eax,%eax
801052ce:	78 30                	js     80105300 <sys_mkdir+0x50>
801052d0:	83 ec 0c             	sub    $0xc,%esp
801052d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052d6:	31 c9                	xor    %ecx,%ecx
801052d8:	6a 00                	push   $0x0
801052da:	ba 01 00 00 00       	mov    $0x1,%edx
801052df:	e8 2c f7 ff ff       	call   80104a10 <create>
801052e4:	83 c4 10             	add    $0x10,%esp
801052e7:	85 c0                	test   %eax,%eax
801052e9:	74 15                	je     80105300 <sys_mkdir+0x50>
801052eb:	83 ec 0c             	sub    $0xc,%esp
801052ee:	50                   	push   %eax
801052ef:	e8 0c c6 ff ff       	call   80101900 <iunlockput>
801052f4:	e8 c7 d8 ff ff       	call   80102bc0 <end_op>
801052f9:	83 c4 10             	add    $0x10,%esp
801052fc:	31 c0                	xor    %eax,%eax
801052fe:	c9                   	leave  
801052ff:	c3                   	ret    
80105300:	e8 bb d8 ff ff       	call   80102bc0 <end_op>
80105305:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010530a:	c9                   	leave  
8010530b:	c3                   	ret    
8010530c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105310 <sys_mknod>:
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	83 ec 18             	sub    $0x18,%esp
80105316:	e8 35 d8 ff ff       	call   80102b50 <begin_op>
8010531b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010531e:	83 ec 08             	sub    $0x8,%esp
80105321:	50                   	push   %eax
80105322:	6a 00                	push   $0x0
80105324:	e8 47 f6 ff ff       	call   80104970 <argstr>
80105329:	83 c4 10             	add    $0x10,%esp
8010532c:	85 c0                	test   %eax,%eax
8010532e:	78 60                	js     80105390 <sys_mknod+0x80>
80105330:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105333:	83 ec 08             	sub    $0x8,%esp
80105336:	50                   	push   %eax
80105337:	6a 01                	push   $0x1
80105339:	e8 82 f5 ff ff       	call   801048c0 <argint>
8010533e:	83 c4 10             	add    $0x10,%esp
80105341:	85 c0                	test   %eax,%eax
80105343:	78 4b                	js     80105390 <sys_mknod+0x80>
80105345:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105348:	83 ec 08             	sub    $0x8,%esp
8010534b:	50                   	push   %eax
8010534c:	6a 02                	push   $0x2
8010534e:	e8 6d f5 ff ff       	call   801048c0 <argint>
80105353:	83 c4 10             	add    $0x10,%esp
80105356:	85 c0                	test   %eax,%eax
80105358:	78 36                	js     80105390 <sys_mknod+0x80>
8010535a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010535e:	83 ec 0c             	sub    $0xc,%esp
80105361:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105365:	ba 03 00 00 00       	mov    $0x3,%edx
8010536a:	50                   	push   %eax
8010536b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010536e:	e8 9d f6 ff ff       	call   80104a10 <create>
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	85 c0                	test   %eax,%eax
80105378:	74 16                	je     80105390 <sys_mknod+0x80>
8010537a:	83 ec 0c             	sub    $0xc,%esp
8010537d:	50                   	push   %eax
8010537e:	e8 7d c5 ff ff       	call   80101900 <iunlockput>
80105383:	e8 38 d8 ff ff       	call   80102bc0 <end_op>
80105388:	83 c4 10             	add    $0x10,%esp
8010538b:	31 c0                	xor    %eax,%eax
8010538d:	c9                   	leave  
8010538e:	c3                   	ret    
8010538f:	90                   	nop
80105390:	e8 2b d8 ff ff       	call   80102bc0 <end_op>
80105395:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010539a:	c9                   	leave  
8010539b:	c3                   	ret    
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053a0 <sys_chdir>:
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	56                   	push   %esi
801053a4:	53                   	push   %ebx
801053a5:	83 ec 10             	sub    $0x10,%esp
801053a8:	e8 e3 e3 ff ff       	call   80103790 <myproc>
801053ad:	89 c6                	mov    %eax,%esi
801053af:	e8 9c d7 ff ff       	call   80102b50 <begin_op>
801053b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053b7:	83 ec 08             	sub    $0x8,%esp
801053ba:	50                   	push   %eax
801053bb:	6a 00                	push   $0x0
801053bd:	e8 ae f5 ff ff       	call   80104970 <argstr>
801053c2:	83 c4 10             	add    $0x10,%esp
801053c5:	85 c0                	test   %eax,%eax
801053c7:	78 77                	js     80105440 <sys_chdir+0xa0>
801053c9:	83 ec 0c             	sub    $0xc,%esp
801053cc:	ff 75 f4             	pushl  -0xc(%ebp)
801053cf:	e8 ec ca ff ff       	call   80101ec0 <namei>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	89 c3                	mov    %eax,%ebx
801053db:	74 63                	je     80105440 <sys_chdir+0xa0>
801053dd:	83 ec 0c             	sub    $0xc,%esp
801053e0:	50                   	push   %eax
801053e1:	e8 8a c2 ff ff       	call   80101670 <ilock>
801053e6:	83 c4 10             	add    $0x10,%esp
801053e9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053ee:	75 30                	jne    80105420 <sys_chdir+0x80>
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	53                   	push   %ebx
801053f4:	e8 57 c3 ff ff       	call   80101750 <iunlock>
801053f9:	58                   	pop    %eax
801053fa:	ff 76 68             	pushl  0x68(%esi)
801053fd:	e8 9e c3 ff ff       	call   801017a0 <iput>
80105402:	e8 b9 d7 ff ff       	call   80102bc0 <end_op>
80105407:	89 5e 68             	mov    %ebx,0x68(%esi)
8010540a:	83 c4 10             	add    $0x10,%esp
8010540d:	31 c0                	xor    %eax,%eax
8010540f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105412:	5b                   	pop    %ebx
80105413:	5e                   	pop    %esi
80105414:	5d                   	pop    %ebp
80105415:	c3                   	ret    
80105416:	8d 76 00             	lea    0x0(%esi),%esi
80105419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105420:	83 ec 0c             	sub    $0xc,%esp
80105423:	53                   	push   %ebx
80105424:	e8 d7 c4 ff ff       	call   80101900 <iunlockput>
80105429:	e8 92 d7 ff ff       	call   80102bc0 <end_op>
8010542e:	83 c4 10             	add    $0x10,%esp
80105431:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105436:	eb d7                	jmp    8010540f <sys_chdir+0x6f>
80105438:	90                   	nop
80105439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105440:	e8 7b d7 ff ff       	call   80102bc0 <end_op>
80105445:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010544a:	eb c3                	jmp    8010540f <sys_chdir+0x6f>
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <sys_exec>:
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	57                   	push   %edi
80105454:	56                   	push   %esi
80105455:	53                   	push   %ebx
80105456:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010545c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105462:	50                   	push   %eax
80105463:	6a 00                	push   $0x0
80105465:	e8 06 f5 ff ff       	call   80104970 <argstr>
8010546a:	83 c4 10             	add    $0x10,%esp
8010546d:	85 c0                	test   %eax,%eax
8010546f:	78 7f                	js     801054f0 <sys_exec+0xa0>
80105471:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105477:	83 ec 08             	sub    $0x8,%esp
8010547a:	50                   	push   %eax
8010547b:	6a 01                	push   $0x1
8010547d:	e8 3e f4 ff ff       	call   801048c0 <argint>
80105482:	83 c4 10             	add    $0x10,%esp
80105485:	85 c0                	test   %eax,%eax
80105487:	78 67                	js     801054f0 <sys_exec+0xa0>
80105489:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010548f:	83 ec 04             	sub    $0x4,%esp
80105492:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105498:	68 80 00 00 00       	push   $0x80
8010549d:	6a 00                	push   $0x0
8010549f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801054a5:	50                   	push   %eax
801054a6:	31 db                	xor    %ebx,%ebx
801054a8:	e8 03 f1 ff ff       	call   801045b0 <memset>
801054ad:	83 c4 10             	add    $0x10,%esp
801054b0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801054b6:	83 ec 08             	sub    $0x8,%esp
801054b9:	57                   	push   %edi
801054ba:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801054bd:	50                   	push   %eax
801054be:	e8 5d f3 ff ff       	call   80104820 <fetchint>
801054c3:	83 c4 10             	add    $0x10,%esp
801054c6:	85 c0                	test   %eax,%eax
801054c8:	78 26                	js     801054f0 <sys_exec+0xa0>
801054ca:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054d0:	85 c0                	test   %eax,%eax
801054d2:	74 2c                	je     80105500 <sys_exec+0xb0>
801054d4:	83 ec 08             	sub    $0x8,%esp
801054d7:	56                   	push   %esi
801054d8:	50                   	push   %eax
801054d9:	e8 82 f3 ff ff       	call   80104860 <fetchstr>
801054de:	83 c4 10             	add    $0x10,%esp
801054e1:	85 c0                	test   %eax,%eax
801054e3:	78 0b                	js     801054f0 <sys_exec+0xa0>
801054e5:	83 c3 01             	add    $0x1,%ebx
801054e8:	83 c6 04             	add    $0x4,%esi
801054eb:	83 fb 20             	cmp    $0x20,%ebx
801054ee:	75 c0                	jne    801054b0 <sys_exec+0x60>
801054f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054f8:	5b                   	pop    %ebx
801054f9:	5e                   	pop    %esi
801054fa:	5f                   	pop    %edi
801054fb:	5d                   	pop    %ebp
801054fc:	c3                   	ret    
801054fd:	8d 76 00             	lea    0x0(%esi),%esi
80105500:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105506:	83 ec 08             	sub    $0x8,%esp
80105509:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105510:	00 00 00 00 
80105514:	50                   	push   %eax
80105515:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010551b:	e8 d0 b4 ff ff       	call   801009f0 <exec>
80105520:	83 c4 10             	add    $0x10,%esp
80105523:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105526:	5b                   	pop    %ebx
80105527:	5e                   	pop    %esi
80105528:	5f                   	pop    %edi
80105529:	5d                   	pop    %ebp
8010552a:	c3                   	ret    
8010552b:	90                   	nop
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105530 <sys_pipe>:
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	57                   	push   %edi
80105534:	56                   	push   %esi
80105535:	53                   	push   %ebx
80105536:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105539:	83 ec 20             	sub    $0x20,%esp
8010553c:	6a 08                	push   $0x8
8010553e:	50                   	push   %eax
8010553f:	6a 00                	push   $0x0
80105541:	e8 ca f3 ff ff       	call   80104910 <argptr>
80105546:	83 c4 10             	add    $0x10,%esp
80105549:	85 c0                	test   %eax,%eax
8010554b:	78 4a                	js     80105597 <sys_pipe+0x67>
8010554d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105550:	83 ec 08             	sub    $0x8,%esp
80105553:	50                   	push   %eax
80105554:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105557:	50                   	push   %eax
80105558:	e8 93 dc ff ff       	call   801031f0 <pipealloc>
8010555d:	83 c4 10             	add    $0x10,%esp
80105560:	85 c0                	test   %eax,%eax
80105562:	78 33                	js     80105597 <sys_pipe+0x67>
80105564:	31 db                	xor    %ebx,%ebx
80105566:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105569:	e8 22 e2 ff ff       	call   80103790 <myproc>
8010556e:	66 90                	xchg   %ax,%ax
80105570:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105574:	85 f6                	test   %esi,%esi
80105576:	74 30                	je     801055a8 <sys_pipe+0x78>
80105578:	83 c3 01             	add    $0x1,%ebx
8010557b:	83 fb 10             	cmp    $0x10,%ebx
8010557e:	75 f0                	jne    80105570 <sys_pipe+0x40>
80105580:	83 ec 0c             	sub    $0xc,%esp
80105583:	ff 75 e0             	pushl  -0x20(%ebp)
80105586:	e8 a5 b8 ff ff       	call   80100e30 <fileclose>
8010558b:	58                   	pop    %eax
8010558c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010558f:	e8 9c b8 ff ff       	call   80100e30 <fileclose>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010559a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010559f:	5b                   	pop    %ebx
801055a0:	5e                   	pop    %esi
801055a1:	5f                   	pop    %edi
801055a2:	5d                   	pop    %ebp
801055a3:	c3                   	ret    
801055a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055a8:	8d 73 08             	lea    0x8(%ebx),%esi
801055ab:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
801055af:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801055b2:	e8 d9 e1 ff ff       	call   80103790 <myproc>
801055b7:	31 d2                	xor    %edx,%edx
801055b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055c0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801055c4:	85 c9                	test   %ecx,%ecx
801055c6:	74 18                	je     801055e0 <sys_pipe+0xb0>
801055c8:	83 c2 01             	add    $0x1,%edx
801055cb:	83 fa 10             	cmp    $0x10,%edx
801055ce:	75 f0                	jne    801055c0 <sys_pipe+0x90>
801055d0:	e8 bb e1 ff ff       	call   80103790 <myproc>
801055d5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801055dc:	00 
801055dd:	eb a1                	jmp    80105580 <sys_pipe+0x50>
801055df:	90                   	nop
801055e0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
801055e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055e7:	89 18                	mov    %ebx,(%eax)
801055e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055ec:	89 50 04             	mov    %edx,0x4(%eax)
801055ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055f2:	31 c0                	xor    %eax,%eax
801055f4:	5b                   	pop    %ebx
801055f5:	5e                   	pop    %esi
801055f6:	5f                   	pop    %edi
801055f7:	5d                   	pop    %ebp
801055f8:	c3                   	ret    
801055f9:	66 90                	xchg   %ax,%ax
801055fb:	66 90                	xchg   %ax,%ax
801055fd:	66 90                	xchg   %ax,%ax
801055ff:	90                   	nop

80105600 <sys_fork>:
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	5d                   	pop    %ebp
80105604:	e9 27 e3 ff ff       	jmp    80103930 <fork>
80105609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105610 <sys_exit>:
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 08             	sub    $0x8,%esp
80105616:	e8 25 e6 ff ff       	call   80103c40 <exit>
8010561b:	31 c0                	xor    %eax,%eax
8010561d:	c9                   	leave  
8010561e:	c3                   	ret    
8010561f:	90                   	nop

80105620 <sys_wait>:
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	5d                   	pop    %ebp
80105624:	e9 57 e8 ff ff       	jmp    80103e80 <wait>
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105630 <sys_kill>:
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	83 ec 20             	sub    $0x20,%esp
80105636:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105639:	50                   	push   %eax
8010563a:	6a 00                	push   $0x0
8010563c:	e8 7f f2 ff ff       	call   801048c0 <argint>
80105641:	83 c4 10             	add    $0x10,%esp
80105644:	85 c0                	test   %eax,%eax
80105646:	78 18                	js     80105660 <sys_kill+0x30>
80105648:	83 ec 0c             	sub    $0xc,%esp
8010564b:	ff 75 f4             	pushl  -0xc(%ebp)
8010564e:	e8 7d e9 ff ff       	call   80103fd0 <kill>
80105653:	83 c4 10             	add    $0x10,%esp
80105656:	c9                   	leave  
80105657:	c3                   	ret    
80105658:	90                   	nop
80105659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105665:	c9                   	leave  
80105666:	c3                   	ret    
80105667:	89 f6                	mov    %esi,%esi
80105669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105670 <sys_getpid>:
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 08             	sub    $0x8,%esp
80105676:	e8 15 e1 ff ff       	call   80103790 <myproc>
8010567b:	8b 40 10             	mov    0x10(%eax),%eax
8010567e:	c9                   	leave  
8010567f:	c3                   	ret    

80105680 <sys_sbrk>:
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	53                   	push   %ebx
80105684:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105687:	83 ec 1c             	sub    $0x1c,%esp
8010568a:	50                   	push   %eax
8010568b:	6a 00                	push   $0x0
8010568d:	e8 2e f2 ff ff       	call   801048c0 <argint>
80105692:	83 c4 10             	add    $0x10,%esp
80105695:	85 c0                	test   %eax,%eax
80105697:	78 27                	js     801056c0 <sys_sbrk+0x40>
80105699:	e8 f2 e0 ff ff       	call   80103790 <myproc>
8010569e:	83 ec 0c             	sub    $0xc,%esp
801056a1:	8b 18                	mov    (%eax),%ebx
801056a3:	ff 75 f4             	pushl  -0xc(%ebp)
801056a6:	e8 05 e2 ff ff       	call   801038b0 <growproc>
801056ab:	83 c4 10             	add    $0x10,%esp
801056ae:	85 c0                	test   %eax,%eax
801056b0:	78 0e                	js     801056c0 <sys_sbrk+0x40>
801056b2:	89 d8                	mov    %ebx,%eax
801056b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056b7:	c9                   	leave  
801056b8:	c3                   	ret    
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056c5:	eb ed                	jmp    801056b4 <sys_sbrk+0x34>
801056c7:	89 f6                	mov    %esi,%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056d0 <sys_sleep>:
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	53                   	push   %ebx
801056d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056d7:	83 ec 1c             	sub    $0x1c,%esp
801056da:	50                   	push   %eax
801056db:	6a 00                	push   $0x0
801056dd:	e8 de f1 ff ff       	call   801048c0 <argint>
801056e2:	83 c4 10             	add    $0x10,%esp
801056e5:	85 c0                	test   %eax,%eax
801056e7:	0f 88 8a 00 00 00    	js     80105777 <sys_sleep+0xa7>
801056ed:	83 ec 0c             	sub    $0xc,%esp
801056f0:	68 60 4d 11 80       	push   $0x80114d60
801056f5:	e8 46 ed ff ff       	call   80104440 <acquire>
801056fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056fd:	83 c4 10             	add    $0x10,%esp
80105700:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
80105706:	85 d2                	test   %edx,%edx
80105708:	75 27                	jne    80105731 <sys_sleep+0x61>
8010570a:	eb 54                	jmp    80105760 <sys_sleep+0x90>
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105710:	83 ec 08             	sub    $0x8,%esp
80105713:	68 60 4d 11 80       	push   $0x80114d60
80105718:	68 a0 55 11 80       	push   $0x801155a0
8010571d:	e8 9e e6 ff ff       	call   80103dc0 <sleep>
80105722:	a1 a0 55 11 80       	mov    0x801155a0,%eax
80105727:	83 c4 10             	add    $0x10,%esp
8010572a:	29 d8                	sub    %ebx,%eax
8010572c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010572f:	73 2f                	jae    80105760 <sys_sleep+0x90>
80105731:	e8 5a e0 ff ff       	call   80103790 <myproc>
80105736:	8b 40 24             	mov    0x24(%eax),%eax
80105739:	85 c0                	test   %eax,%eax
8010573b:	74 d3                	je     80105710 <sys_sleep+0x40>
8010573d:	83 ec 0c             	sub    $0xc,%esp
80105740:	68 60 4d 11 80       	push   $0x80114d60
80105745:	e8 16 ee ff ff       	call   80104560 <release>
8010574a:	83 c4 10             	add    $0x10,%esp
8010574d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105752:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105755:	c9                   	leave  
80105756:	c3                   	ret    
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105760:	83 ec 0c             	sub    $0xc,%esp
80105763:	68 60 4d 11 80       	push   $0x80114d60
80105768:	e8 f3 ed ff ff       	call   80104560 <release>
8010576d:	83 c4 10             	add    $0x10,%esp
80105770:	31 c0                	xor    %eax,%eax
80105772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105775:	c9                   	leave  
80105776:	c3                   	ret    
80105777:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010577c:	eb d4                	jmp    80105752 <sys_sleep+0x82>
8010577e:	66 90                	xchg   %ax,%ax

80105780 <sys_uptime>:
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
80105784:	83 ec 10             	sub    $0x10,%esp
80105787:	68 60 4d 11 80       	push   $0x80114d60
8010578c:	e8 af ec ff ff       	call   80104440 <acquire>
80105791:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
80105797:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
8010579e:	e8 bd ed ff ff       	call   80104560 <release>
801057a3:	89 d8                	mov    %ebx,%eax
801057a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057a8:	c9                   	leave  
801057a9:	c3                   	ret    
801057aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057b0 <sys_cps>:
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	5d                   	pop    %ebp
801057b4:	e9 67 e9 ff ff       	jmp    80104120 <cps>
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057c0 <sys_chpr>:
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	83 ec 20             	sub    $0x20,%esp
801057c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057c9:	50                   	push   %eax
801057ca:	6a 00                	push   $0x0
801057cc:	e8 ef f0 ff ff       	call   801048c0 <argint>
801057d1:	83 c4 10             	add    $0x10,%esp
801057d4:	85 c0                	test   %eax,%eax
801057d6:	78 28                	js     80105800 <sys_chpr+0x40>
801057d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057db:	83 ec 08             	sub    $0x8,%esp
801057de:	50                   	push   %eax
801057df:	6a 01                	push   $0x1
801057e1:	e8 da f0 ff ff       	call   801048c0 <argint>
801057e6:	83 c4 10             	add    $0x10,%esp
801057e9:	85 c0                	test   %eax,%eax
801057eb:	78 13                	js     80105800 <sys_chpr+0x40>
801057ed:	83 ec 08             	sub    $0x8,%esp
801057f0:	ff 75 f4             	pushl  -0xc(%ebp)
801057f3:	ff 75 f0             	pushl  -0x10(%ebp)
801057f6:	e8 e5 e9 ff ff       	call   801041e0 <chpr>
801057fb:	83 c4 10             	add    $0x10,%esp
801057fe:	c9                   	leave  
801057ff:	c3                   	ret    
80105800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105805:	c9                   	leave  
80105806:	c3                   	ret    

80105807 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105807:	1e                   	push   %ds
  pushl %es
80105808:	06                   	push   %es
  pushl %fs
80105809:	0f a0                	push   %fs
  pushl %gs
8010580b:	0f a8                	push   %gs
  pushal
8010580d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010580e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105812:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105814:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105816:	54                   	push   %esp
  call trap
80105817:	e8 e4 00 00 00       	call   80105900 <trap>
  addl $4, %esp
8010581c:	83 c4 04             	add    $0x4,%esp

8010581f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010581f:	61                   	popa   
  popl %gs
80105820:	0f a9                	pop    %gs
  popl %fs
80105822:	0f a1                	pop    %fs
  popl %es
80105824:	07                   	pop    %es
  popl %ds
80105825:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105826:	83 c4 08             	add    $0x8,%esp
  iret
80105829:	cf                   	iret   
8010582a:	66 90                	xchg   %ax,%ax
8010582c:	66 90                	xchg   %ax,%ax
8010582e:	66 90                	xchg   %ax,%ax

80105830 <tvinit>:
80105830:	31 c0                	xor    %eax,%eax
80105832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105838:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010583f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105844:	c6 04 c5 a4 4d 11 80 	movb   $0x0,-0x7feeb25c(,%eax,8)
8010584b:	00 
8010584c:	66 89 0c c5 a2 4d 11 	mov    %cx,-0x7feeb25e(,%eax,8)
80105853:	80 
80105854:	c6 04 c5 a5 4d 11 80 	movb   $0x8e,-0x7feeb25b(,%eax,8)
8010585b:	8e 
8010585c:	66 89 14 c5 a0 4d 11 	mov    %dx,-0x7feeb260(,%eax,8)
80105863:	80 
80105864:	c1 ea 10             	shr    $0x10,%edx
80105867:	66 89 14 c5 a6 4d 11 	mov    %dx,-0x7feeb25a(,%eax,8)
8010586e:	80 
8010586f:	83 c0 01             	add    $0x1,%eax
80105872:	3d 00 01 00 00       	cmp    $0x100,%eax
80105877:	75 bf                	jne    80105838 <tvinit+0x8>
80105879:	55                   	push   %ebp
8010587a:	ba 08 00 00 00       	mov    $0x8,%edx
8010587f:	89 e5                	mov    %esp,%ebp
80105881:	83 ec 10             	sub    $0x10,%esp
80105884:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105889:	68 e1 78 10 80       	push   $0x801078e1
8010588e:	68 60 4d 11 80       	push   $0x80114d60
80105893:	66 89 15 a2 4f 11 80 	mov    %dx,0x80114fa2
8010589a:	c6 05 a4 4f 11 80 00 	movb   $0x0,0x80114fa4
801058a1:	66 a3 a0 4f 11 80    	mov    %ax,0x80114fa0
801058a7:	c1 e8 10             	shr    $0x10,%eax
801058aa:	c6 05 a5 4f 11 80 ef 	movb   $0xef,0x80114fa5
801058b1:	66 a3 a6 4f 11 80    	mov    %ax,0x80114fa6
801058b7:	e8 84 ea ff ff       	call   80104340 <initlock>
801058bc:	83 c4 10             	add    $0x10,%esp
801058bf:	c9                   	leave  
801058c0:	c3                   	ret    
801058c1:	eb 0d                	jmp    801058d0 <idtinit>
801058c3:	90                   	nop
801058c4:	90                   	nop
801058c5:	90                   	nop
801058c6:	90                   	nop
801058c7:	90                   	nop
801058c8:	90                   	nop
801058c9:	90                   	nop
801058ca:	90                   	nop
801058cb:	90                   	nop
801058cc:	90                   	nop
801058cd:	90                   	nop
801058ce:	90                   	nop
801058cf:	90                   	nop

801058d0 <idtinit>:
801058d0:	55                   	push   %ebp
801058d1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801058d6:	89 e5                	mov    %esp,%ebp
801058d8:	83 ec 10             	sub    $0x10,%esp
801058db:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
801058df:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
801058e4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801058e8:	c1 e8 10             	shr    $0x10,%eax
801058eb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
801058ef:	8d 45 fa             	lea    -0x6(%ebp),%eax
801058f2:	0f 01 18             	lidtl  (%eax)
801058f5:	c9                   	leave  
801058f6:	c3                   	ret    
801058f7:	89 f6                	mov    %esi,%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105900 <trap>:
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	57                   	push   %edi
80105904:	56                   	push   %esi
80105905:	53                   	push   %ebx
80105906:	83 ec 1c             	sub    $0x1c,%esp
80105909:	8b 7d 08             	mov    0x8(%ebp),%edi
8010590c:	8b 47 30             	mov    0x30(%edi),%eax
8010590f:	83 f8 40             	cmp    $0x40,%eax
80105912:	0f 84 88 01 00 00    	je     80105aa0 <trap+0x1a0>
80105918:	83 e8 20             	sub    $0x20,%eax
8010591b:	83 f8 1f             	cmp    $0x1f,%eax
8010591e:	77 10                	ja     80105930 <trap+0x30>
80105920:	ff 24 85 88 79 10 80 	jmp    *-0x7fef8678(,%eax,4)
80105927:	89 f6                	mov    %esi,%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105930:	e8 5b de ff ff       	call   80103790 <myproc>
80105935:	85 c0                	test   %eax,%eax
80105937:	0f 84 d7 01 00 00    	je     80105b14 <trap+0x214>
8010593d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105941:	0f 84 cd 01 00 00    	je     80105b14 <trap+0x214>
80105947:	0f 20 d1             	mov    %cr2,%ecx
8010594a:	8b 57 38             	mov    0x38(%edi),%edx
8010594d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105950:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105953:	e8 18 de ff ff       	call   80103770 <cpuid>
80105958:	8b 77 34             	mov    0x34(%edi),%esi
8010595b:	8b 5f 30             	mov    0x30(%edi),%ebx
8010595e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105961:	e8 2a de ff ff       	call   80103790 <myproc>
80105966:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105969:	e8 22 de ff ff       	call   80103790 <myproc>
8010596e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105971:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105974:	51                   	push   %ecx
80105975:	52                   	push   %edx
80105976:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105979:	ff 75 e4             	pushl  -0x1c(%ebp)
8010597c:	56                   	push   %esi
8010597d:	53                   	push   %ebx
8010597e:	83 c2 6c             	add    $0x6c,%edx
80105981:	52                   	push   %edx
80105982:	ff 70 10             	pushl  0x10(%eax)
80105985:	68 44 79 10 80       	push   $0x80107944
8010598a:	e8 d1 ac ff ff       	call   80100660 <cprintf>
8010598f:	83 c4 20             	add    $0x20,%esp
80105992:	e8 f9 dd ff ff       	call   80103790 <myproc>
80105997:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010599e:	66 90                	xchg   %ax,%ax
801059a0:	e8 eb dd ff ff       	call   80103790 <myproc>
801059a5:	85 c0                	test   %eax,%eax
801059a7:	74 0c                	je     801059b5 <trap+0xb5>
801059a9:	e8 e2 dd ff ff       	call   80103790 <myproc>
801059ae:	8b 50 24             	mov    0x24(%eax),%edx
801059b1:	85 d2                	test   %edx,%edx
801059b3:	75 4b                	jne    80105a00 <trap+0x100>
801059b5:	e8 d6 dd ff ff       	call   80103790 <myproc>
801059ba:	85 c0                	test   %eax,%eax
801059bc:	74 0b                	je     801059c9 <trap+0xc9>
801059be:	e8 cd dd ff ff       	call   80103790 <myproc>
801059c3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801059c7:	74 4f                	je     80105a18 <trap+0x118>
801059c9:	e8 c2 dd ff ff       	call   80103790 <myproc>
801059ce:	85 c0                	test   %eax,%eax
801059d0:	74 1d                	je     801059ef <trap+0xef>
801059d2:	e8 b9 dd ff ff       	call   80103790 <myproc>
801059d7:	8b 40 24             	mov    0x24(%eax),%eax
801059da:	85 c0                	test   %eax,%eax
801059dc:	74 11                	je     801059ef <trap+0xef>
801059de:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059e2:	83 e0 03             	and    $0x3,%eax
801059e5:	66 83 f8 03          	cmp    $0x3,%ax
801059e9:	0f 84 da 00 00 00    	je     80105ac9 <trap+0x1c9>
801059ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059f2:	5b                   	pop    %ebx
801059f3:	5e                   	pop    %esi
801059f4:	5f                   	pop    %edi
801059f5:	5d                   	pop    %ebp
801059f6:	c3                   	ret    
801059f7:	89 f6                	mov    %esi,%esi
801059f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105a00:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105a04:	83 e0 03             	and    $0x3,%eax
80105a07:	66 83 f8 03          	cmp    $0x3,%ax
80105a0b:	75 a8                	jne    801059b5 <trap+0xb5>
80105a0d:	e8 2e e2 ff ff       	call   80103c40 <exit>
80105a12:	eb a1                	jmp    801059b5 <trap+0xb5>
80105a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a18:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105a1c:	75 ab                	jne    801059c9 <trap+0xc9>
80105a1e:	e8 4d e3 ff ff       	call   80103d70 <yield>
80105a23:	eb a4                	jmp    801059c9 <trap+0xc9>
80105a25:	8d 76 00             	lea    0x0(%esi),%esi
80105a28:	e8 43 dd ff ff       	call   80103770 <cpuid>
80105a2d:	85 c0                	test   %eax,%eax
80105a2f:	0f 84 ab 00 00 00    	je     80105ae0 <trap+0x1e0>
80105a35:	e8 d6 cc ff ff       	call   80102710 <lapiceoi>
80105a3a:	e9 61 ff ff ff       	jmp    801059a0 <trap+0xa0>
80105a3f:	90                   	nop
80105a40:	e8 8b cb ff ff       	call   801025d0 <kbdintr>
80105a45:	e8 c6 cc ff ff       	call   80102710 <lapiceoi>
80105a4a:	e9 51 ff ff ff       	jmp    801059a0 <trap+0xa0>
80105a4f:	90                   	nop
80105a50:	e8 5b 02 00 00       	call   80105cb0 <uartintr>
80105a55:	e8 b6 cc ff ff       	call   80102710 <lapiceoi>
80105a5a:	e9 41 ff ff ff       	jmp    801059a0 <trap+0xa0>
80105a5f:	90                   	nop
80105a60:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105a64:	8b 77 38             	mov    0x38(%edi),%esi
80105a67:	e8 04 dd ff ff       	call   80103770 <cpuid>
80105a6c:	56                   	push   %esi
80105a6d:	53                   	push   %ebx
80105a6e:	50                   	push   %eax
80105a6f:	68 ec 78 10 80       	push   $0x801078ec
80105a74:	e8 e7 ab ff ff       	call   80100660 <cprintf>
80105a79:	e8 92 cc ff ff       	call   80102710 <lapiceoi>
80105a7e:	83 c4 10             	add    $0x10,%esp
80105a81:	e9 1a ff ff ff       	jmp    801059a0 <trap+0xa0>
80105a86:	8d 76 00             	lea    0x0(%esi),%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105a90:	e8 bb c5 ff ff       	call   80102050 <ideintr>
80105a95:	eb 9e                	jmp    80105a35 <trap+0x135>
80105a97:	89 f6                	mov    %esi,%esi
80105a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105aa0:	e8 eb dc ff ff       	call   80103790 <myproc>
80105aa5:	8b 58 24             	mov    0x24(%eax),%ebx
80105aa8:	85 db                	test   %ebx,%ebx
80105aaa:	75 2c                	jne    80105ad8 <trap+0x1d8>
80105aac:	e8 df dc ff ff       	call   80103790 <myproc>
80105ab1:	89 78 18             	mov    %edi,0x18(%eax)
80105ab4:	e8 f7 ee ff ff       	call   801049b0 <syscall>
80105ab9:	e8 d2 dc ff ff       	call   80103790 <myproc>
80105abe:	8b 48 24             	mov    0x24(%eax),%ecx
80105ac1:	85 c9                	test   %ecx,%ecx
80105ac3:	0f 84 26 ff ff ff    	je     801059ef <trap+0xef>
80105ac9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105acc:	5b                   	pop    %ebx
80105acd:	5e                   	pop    %esi
80105ace:	5f                   	pop    %edi
80105acf:	5d                   	pop    %ebp
80105ad0:	e9 6b e1 ff ff       	jmp    80103c40 <exit>
80105ad5:	8d 76 00             	lea    0x0(%esi),%esi
80105ad8:	e8 63 e1 ff ff       	call   80103c40 <exit>
80105add:	eb cd                	jmp    80105aac <trap+0x1ac>
80105adf:	90                   	nop
80105ae0:	83 ec 0c             	sub    $0xc,%esp
80105ae3:	68 60 4d 11 80       	push   $0x80114d60
80105ae8:	e8 53 e9 ff ff       	call   80104440 <acquire>
80105aed:	c7 04 24 a0 55 11 80 	movl   $0x801155a0,(%esp)
80105af4:	83 05 a0 55 11 80 01 	addl   $0x1,0x801155a0
80105afb:	e8 70 e4 ff ff       	call   80103f70 <wakeup>
80105b00:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
80105b07:	e8 54 ea ff ff       	call   80104560 <release>
80105b0c:	83 c4 10             	add    $0x10,%esp
80105b0f:	e9 21 ff ff ff       	jmp    80105a35 <trap+0x135>
80105b14:	0f 20 d6             	mov    %cr2,%esi
80105b17:	8b 5f 38             	mov    0x38(%edi),%ebx
80105b1a:	e8 51 dc ff ff       	call   80103770 <cpuid>
80105b1f:	83 ec 0c             	sub    $0xc,%esp
80105b22:	56                   	push   %esi
80105b23:	53                   	push   %ebx
80105b24:	50                   	push   %eax
80105b25:	ff 77 30             	pushl  0x30(%edi)
80105b28:	68 10 79 10 80       	push   $0x80107910
80105b2d:	e8 2e ab ff ff       	call   80100660 <cprintf>
80105b32:	83 c4 14             	add    $0x14,%esp
80105b35:	68 e6 78 10 80       	push   $0x801078e6
80105b3a:	e8 31 a8 ff ff       	call   80100370 <panic>
80105b3f:	90                   	nop

80105b40 <uartgetc>:
80105b40:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105b45:	55                   	push   %ebp
80105b46:	89 e5                	mov    %esp,%ebp
80105b48:	85 c0                	test   %eax,%eax
80105b4a:	74 1c                	je     80105b68 <uartgetc+0x28>
80105b4c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b51:	ec                   	in     (%dx),%al
80105b52:	a8 01                	test   $0x1,%al
80105b54:	74 12                	je     80105b68 <uartgetc+0x28>
80105b56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b5b:	ec                   	in     (%dx),%al
80105b5c:	0f b6 c0             	movzbl %al,%eax
80105b5f:	5d                   	pop    %ebp
80105b60:	c3                   	ret    
80105b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b6d:	5d                   	pop    %ebp
80105b6e:	c3                   	ret    
80105b6f:	90                   	nop

80105b70 <uartputc.part.0>:
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	57                   	push   %edi
80105b74:	56                   	push   %esi
80105b75:	53                   	push   %ebx
80105b76:	89 c7                	mov    %eax,%edi
80105b78:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b7d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105b82:	83 ec 0c             	sub    $0xc,%esp
80105b85:	eb 1b                	jmp    80105ba2 <uartputc.part.0+0x32>
80105b87:	89 f6                	mov    %esi,%esi
80105b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105b90:	83 ec 0c             	sub    $0xc,%esp
80105b93:	6a 0a                	push   $0xa
80105b95:	e8 96 cb ff ff       	call   80102730 <microdelay>
80105b9a:	83 c4 10             	add    $0x10,%esp
80105b9d:	83 eb 01             	sub    $0x1,%ebx
80105ba0:	74 07                	je     80105ba9 <uartputc.part.0+0x39>
80105ba2:	89 f2                	mov    %esi,%edx
80105ba4:	ec                   	in     (%dx),%al
80105ba5:	a8 20                	test   $0x20,%al
80105ba7:	74 e7                	je     80105b90 <uartputc.part.0+0x20>
80105ba9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bae:	89 f8                	mov    %edi,%eax
80105bb0:	ee                   	out    %al,(%dx)
80105bb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bb4:	5b                   	pop    %ebx
80105bb5:	5e                   	pop    %esi
80105bb6:	5f                   	pop    %edi
80105bb7:	5d                   	pop    %ebp
80105bb8:	c3                   	ret    
80105bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105bc0 <uartinit>:
80105bc0:	55                   	push   %ebp
80105bc1:	31 c9                	xor    %ecx,%ecx
80105bc3:	89 c8                	mov    %ecx,%eax
80105bc5:	89 e5                	mov    %esp,%ebp
80105bc7:	57                   	push   %edi
80105bc8:	56                   	push   %esi
80105bc9:	53                   	push   %ebx
80105bca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105bcf:	89 da                	mov    %ebx,%edx
80105bd1:	83 ec 0c             	sub    $0xc,%esp
80105bd4:	ee                   	out    %al,(%dx)
80105bd5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105bda:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105bdf:	89 fa                	mov    %edi,%edx
80105be1:	ee                   	out    %al,(%dx)
80105be2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105be7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bec:	ee                   	out    %al,(%dx)
80105bed:	be f9 03 00 00       	mov    $0x3f9,%esi
80105bf2:	89 c8                	mov    %ecx,%eax
80105bf4:	89 f2                	mov    %esi,%edx
80105bf6:	ee                   	out    %al,(%dx)
80105bf7:	b8 03 00 00 00       	mov    $0x3,%eax
80105bfc:	89 fa                	mov    %edi,%edx
80105bfe:	ee                   	out    %al,(%dx)
80105bff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c04:	89 c8                	mov    %ecx,%eax
80105c06:	ee                   	out    %al,(%dx)
80105c07:	b8 01 00 00 00       	mov    $0x1,%eax
80105c0c:	89 f2                	mov    %esi,%edx
80105c0e:	ee                   	out    %al,(%dx)
80105c0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c14:	ec                   	in     (%dx),%al
80105c15:	3c ff                	cmp    $0xff,%al
80105c17:	74 5a                	je     80105c73 <uartinit+0xb3>
80105c19:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c20:	00 00 00 
80105c23:	89 da                	mov    %ebx,%edx
80105c25:	ec                   	in     (%dx),%al
80105c26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c2b:	ec                   	in     (%dx),%al
80105c2c:	83 ec 08             	sub    $0x8,%esp
80105c2f:	bb 08 7a 10 80       	mov    $0x80107a08,%ebx
80105c34:	6a 00                	push   $0x0
80105c36:	6a 04                	push   $0x4
80105c38:	e8 63 c6 ff ff       	call   801022a0 <ioapicenable>
80105c3d:	83 c4 10             	add    $0x10,%esp
80105c40:	b8 78 00 00 00       	mov    $0x78,%eax
80105c45:	eb 13                	jmp    80105c5a <uartinit+0x9a>
80105c47:	89 f6                	mov    %esi,%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c50:	83 c3 01             	add    $0x1,%ebx
80105c53:	0f be 03             	movsbl (%ebx),%eax
80105c56:	84 c0                	test   %al,%al
80105c58:	74 19                	je     80105c73 <uartinit+0xb3>
80105c5a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105c60:	85 d2                	test   %edx,%edx
80105c62:	74 ec                	je     80105c50 <uartinit+0x90>
80105c64:	83 c3 01             	add    $0x1,%ebx
80105c67:	e8 04 ff ff ff       	call   80105b70 <uartputc.part.0>
80105c6c:	0f be 03             	movsbl (%ebx),%eax
80105c6f:	84 c0                	test   %al,%al
80105c71:	75 e7                	jne    80105c5a <uartinit+0x9a>
80105c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c76:	5b                   	pop    %ebx
80105c77:	5e                   	pop    %esi
80105c78:	5f                   	pop    %edi
80105c79:	5d                   	pop    %ebp
80105c7a:	c3                   	ret    
80105c7b:	90                   	nop
80105c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c80 <uartputc>:
80105c80:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105c86:	55                   	push   %ebp
80105c87:	89 e5                	mov    %esp,%ebp
80105c89:	85 d2                	test   %edx,%edx
80105c8b:	8b 45 08             	mov    0x8(%ebp),%eax
80105c8e:	74 10                	je     80105ca0 <uartputc+0x20>
80105c90:	5d                   	pop    %ebp
80105c91:	e9 da fe ff ff       	jmp    80105b70 <uartputc.part.0>
80105c96:	8d 76 00             	lea    0x0(%esi),%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ca0:	5d                   	pop    %ebp
80105ca1:	c3                   	ret    
80105ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cb0 <uartintr>:
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	83 ec 14             	sub    $0x14,%esp
80105cb6:	68 40 5b 10 80       	push   $0x80105b40
80105cbb:	e8 30 ab ff ff       	call   801007f0 <consoleintr>
80105cc0:	83 c4 10             	add    $0x10,%esp
80105cc3:	c9                   	leave  
80105cc4:	c3                   	ret    

80105cc5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105cc5:	6a 00                	push   $0x0
  pushl $0
80105cc7:	6a 00                	push   $0x0
  jmp alltraps
80105cc9:	e9 39 fb ff ff       	jmp    80105807 <alltraps>

80105cce <vector1>:
.globl vector1
vector1:
  pushl $0
80105cce:	6a 00                	push   $0x0
  pushl $1
80105cd0:	6a 01                	push   $0x1
  jmp alltraps
80105cd2:	e9 30 fb ff ff       	jmp    80105807 <alltraps>

80105cd7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105cd7:	6a 00                	push   $0x0
  pushl $2
80105cd9:	6a 02                	push   $0x2
  jmp alltraps
80105cdb:	e9 27 fb ff ff       	jmp    80105807 <alltraps>

80105ce0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105ce0:	6a 00                	push   $0x0
  pushl $3
80105ce2:	6a 03                	push   $0x3
  jmp alltraps
80105ce4:	e9 1e fb ff ff       	jmp    80105807 <alltraps>

80105ce9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105ce9:	6a 00                	push   $0x0
  pushl $4
80105ceb:	6a 04                	push   $0x4
  jmp alltraps
80105ced:	e9 15 fb ff ff       	jmp    80105807 <alltraps>

80105cf2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105cf2:	6a 00                	push   $0x0
  pushl $5
80105cf4:	6a 05                	push   $0x5
  jmp alltraps
80105cf6:	e9 0c fb ff ff       	jmp    80105807 <alltraps>

80105cfb <vector6>:
.globl vector6
vector6:
  pushl $0
80105cfb:	6a 00                	push   $0x0
  pushl $6
80105cfd:	6a 06                	push   $0x6
  jmp alltraps
80105cff:	e9 03 fb ff ff       	jmp    80105807 <alltraps>

80105d04 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d04:	6a 00                	push   $0x0
  pushl $7
80105d06:	6a 07                	push   $0x7
  jmp alltraps
80105d08:	e9 fa fa ff ff       	jmp    80105807 <alltraps>

80105d0d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d0d:	6a 08                	push   $0x8
  jmp alltraps
80105d0f:	e9 f3 fa ff ff       	jmp    80105807 <alltraps>

80105d14 <vector9>:
.globl vector9
vector9:
  pushl $0
80105d14:	6a 00                	push   $0x0
  pushl $9
80105d16:	6a 09                	push   $0x9
  jmp alltraps
80105d18:	e9 ea fa ff ff       	jmp    80105807 <alltraps>

80105d1d <vector10>:
.globl vector10
vector10:
  pushl $10
80105d1d:	6a 0a                	push   $0xa
  jmp alltraps
80105d1f:	e9 e3 fa ff ff       	jmp    80105807 <alltraps>

80105d24 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d24:	6a 0b                	push   $0xb
  jmp alltraps
80105d26:	e9 dc fa ff ff       	jmp    80105807 <alltraps>

80105d2b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d2b:	6a 0c                	push   $0xc
  jmp alltraps
80105d2d:	e9 d5 fa ff ff       	jmp    80105807 <alltraps>

80105d32 <vector13>:
.globl vector13
vector13:
  pushl $13
80105d32:	6a 0d                	push   $0xd
  jmp alltraps
80105d34:	e9 ce fa ff ff       	jmp    80105807 <alltraps>

80105d39 <vector14>:
.globl vector14
vector14:
  pushl $14
80105d39:	6a 0e                	push   $0xe
  jmp alltraps
80105d3b:	e9 c7 fa ff ff       	jmp    80105807 <alltraps>

80105d40 <vector15>:
.globl vector15
vector15:
  pushl $0
80105d40:	6a 00                	push   $0x0
  pushl $15
80105d42:	6a 0f                	push   $0xf
  jmp alltraps
80105d44:	e9 be fa ff ff       	jmp    80105807 <alltraps>

80105d49 <vector16>:
.globl vector16
vector16:
  pushl $0
80105d49:	6a 00                	push   $0x0
  pushl $16
80105d4b:	6a 10                	push   $0x10
  jmp alltraps
80105d4d:	e9 b5 fa ff ff       	jmp    80105807 <alltraps>

80105d52 <vector17>:
.globl vector17
vector17:
  pushl $17
80105d52:	6a 11                	push   $0x11
  jmp alltraps
80105d54:	e9 ae fa ff ff       	jmp    80105807 <alltraps>

80105d59 <vector18>:
.globl vector18
vector18:
  pushl $0
80105d59:	6a 00                	push   $0x0
  pushl $18
80105d5b:	6a 12                	push   $0x12
  jmp alltraps
80105d5d:	e9 a5 fa ff ff       	jmp    80105807 <alltraps>

80105d62 <vector19>:
.globl vector19
vector19:
  pushl $0
80105d62:	6a 00                	push   $0x0
  pushl $19
80105d64:	6a 13                	push   $0x13
  jmp alltraps
80105d66:	e9 9c fa ff ff       	jmp    80105807 <alltraps>

80105d6b <vector20>:
.globl vector20
vector20:
  pushl $0
80105d6b:	6a 00                	push   $0x0
  pushl $20
80105d6d:	6a 14                	push   $0x14
  jmp alltraps
80105d6f:	e9 93 fa ff ff       	jmp    80105807 <alltraps>

80105d74 <vector21>:
.globl vector21
vector21:
  pushl $0
80105d74:	6a 00                	push   $0x0
  pushl $21
80105d76:	6a 15                	push   $0x15
  jmp alltraps
80105d78:	e9 8a fa ff ff       	jmp    80105807 <alltraps>

80105d7d <vector22>:
.globl vector22
vector22:
  pushl $0
80105d7d:	6a 00                	push   $0x0
  pushl $22
80105d7f:	6a 16                	push   $0x16
  jmp alltraps
80105d81:	e9 81 fa ff ff       	jmp    80105807 <alltraps>

80105d86 <vector23>:
.globl vector23
vector23:
  pushl $0
80105d86:	6a 00                	push   $0x0
  pushl $23
80105d88:	6a 17                	push   $0x17
  jmp alltraps
80105d8a:	e9 78 fa ff ff       	jmp    80105807 <alltraps>

80105d8f <vector24>:
.globl vector24
vector24:
  pushl $0
80105d8f:	6a 00                	push   $0x0
  pushl $24
80105d91:	6a 18                	push   $0x18
  jmp alltraps
80105d93:	e9 6f fa ff ff       	jmp    80105807 <alltraps>

80105d98 <vector25>:
.globl vector25
vector25:
  pushl $0
80105d98:	6a 00                	push   $0x0
  pushl $25
80105d9a:	6a 19                	push   $0x19
  jmp alltraps
80105d9c:	e9 66 fa ff ff       	jmp    80105807 <alltraps>

80105da1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105da1:	6a 00                	push   $0x0
  pushl $26
80105da3:	6a 1a                	push   $0x1a
  jmp alltraps
80105da5:	e9 5d fa ff ff       	jmp    80105807 <alltraps>

80105daa <vector27>:
.globl vector27
vector27:
  pushl $0
80105daa:	6a 00                	push   $0x0
  pushl $27
80105dac:	6a 1b                	push   $0x1b
  jmp alltraps
80105dae:	e9 54 fa ff ff       	jmp    80105807 <alltraps>

80105db3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105db3:	6a 00                	push   $0x0
  pushl $28
80105db5:	6a 1c                	push   $0x1c
  jmp alltraps
80105db7:	e9 4b fa ff ff       	jmp    80105807 <alltraps>

80105dbc <vector29>:
.globl vector29
vector29:
  pushl $0
80105dbc:	6a 00                	push   $0x0
  pushl $29
80105dbe:	6a 1d                	push   $0x1d
  jmp alltraps
80105dc0:	e9 42 fa ff ff       	jmp    80105807 <alltraps>

80105dc5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105dc5:	6a 00                	push   $0x0
  pushl $30
80105dc7:	6a 1e                	push   $0x1e
  jmp alltraps
80105dc9:	e9 39 fa ff ff       	jmp    80105807 <alltraps>

80105dce <vector31>:
.globl vector31
vector31:
  pushl $0
80105dce:	6a 00                	push   $0x0
  pushl $31
80105dd0:	6a 1f                	push   $0x1f
  jmp alltraps
80105dd2:	e9 30 fa ff ff       	jmp    80105807 <alltraps>

80105dd7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105dd7:	6a 00                	push   $0x0
  pushl $32
80105dd9:	6a 20                	push   $0x20
  jmp alltraps
80105ddb:	e9 27 fa ff ff       	jmp    80105807 <alltraps>

80105de0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105de0:	6a 00                	push   $0x0
  pushl $33
80105de2:	6a 21                	push   $0x21
  jmp alltraps
80105de4:	e9 1e fa ff ff       	jmp    80105807 <alltraps>

80105de9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $34
80105deb:	6a 22                	push   $0x22
  jmp alltraps
80105ded:	e9 15 fa ff ff       	jmp    80105807 <alltraps>

80105df2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105df2:	6a 00                	push   $0x0
  pushl $35
80105df4:	6a 23                	push   $0x23
  jmp alltraps
80105df6:	e9 0c fa ff ff       	jmp    80105807 <alltraps>

80105dfb <vector36>:
.globl vector36
vector36:
  pushl $0
80105dfb:	6a 00                	push   $0x0
  pushl $36
80105dfd:	6a 24                	push   $0x24
  jmp alltraps
80105dff:	e9 03 fa ff ff       	jmp    80105807 <alltraps>

80105e04 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e04:	6a 00                	push   $0x0
  pushl $37
80105e06:	6a 25                	push   $0x25
  jmp alltraps
80105e08:	e9 fa f9 ff ff       	jmp    80105807 <alltraps>

80105e0d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e0d:	6a 00                	push   $0x0
  pushl $38
80105e0f:	6a 26                	push   $0x26
  jmp alltraps
80105e11:	e9 f1 f9 ff ff       	jmp    80105807 <alltraps>

80105e16 <vector39>:
.globl vector39
vector39:
  pushl $0
80105e16:	6a 00                	push   $0x0
  pushl $39
80105e18:	6a 27                	push   $0x27
  jmp alltraps
80105e1a:	e9 e8 f9 ff ff       	jmp    80105807 <alltraps>

80105e1f <vector40>:
.globl vector40
vector40:
  pushl $0
80105e1f:	6a 00                	push   $0x0
  pushl $40
80105e21:	6a 28                	push   $0x28
  jmp alltraps
80105e23:	e9 df f9 ff ff       	jmp    80105807 <alltraps>

80105e28 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e28:	6a 00                	push   $0x0
  pushl $41
80105e2a:	6a 29                	push   $0x29
  jmp alltraps
80105e2c:	e9 d6 f9 ff ff       	jmp    80105807 <alltraps>

80105e31 <vector42>:
.globl vector42
vector42:
  pushl $0
80105e31:	6a 00                	push   $0x0
  pushl $42
80105e33:	6a 2a                	push   $0x2a
  jmp alltraps
80105e35:	e9 cd f9 ff ff       	jmp    80105807 <alltraps>

80105e3a <vector43>:
.globl vector43
vector43:
  pushl $0
80105e3a:	6a 00                	push   $0x0
  pushl $43
80105e3c:	6a 2b                	push   $0x2b
  jmp alltraps
80105e3e:	e9 c4 f9 ff ff       	jmp    80105807 <alltraps>

80105e43 <vector44>:
.globl vector44
vector44:
  pushl $0
80105e43:	6a 00                	push   $0x0
  pushl $44
80105e45:	6a 2c                	push   $0x2c
  jmp alltraps
80105e47:	e9 bb f9 ff ff       	jmp    80105807 <alltraps>

80105e4c <vector45>:
.globl vector45
vector45:
  pushl $0
80105e4c:	6a 00                	push   $0x0
  pushl $45
80105e4e:	6a 2d                	push   $0x2d
  jmp alltraps
80105e50:	e9 b2 f9 ff ff       	jmp    80105807 <alltraps>

80105e55 <vector46>:
.globl vector46
vector46:
  pushl $0
80105e55:	6a 00                	push   $0x0
  pushl $46
80105e57:	6a 2e                	push   $0x2e
  jmp alltraps
80105e59:	e9 a9 f9 ff ff       	jmp    80105807 <alltraps>

80105e5e <vector47>:
.globl vector47
vector47:
  pushl $0
80105e5e:	6a 00                	push   $0x0
  pushl $47
80105e60:	6a 2f                	push   $0x2f
  jmp alltraps
80105e62:	e9 a0 f9 ff ff       	jmp    80105807 <alltraps>

80105e67 <vector48>:
.globl vector48
vector48:
  pushl $0
80105e67:	6a 00                	push   $0x0
  pushl $48
80105e69:	6a 30                	push   $0x30
  jmp alltraps
80105e6b:	e9 97 f9 ff ff       	jmp    80105807 <alltraps>

80105e70 <vector49>:
.globl vector49
vector49:
  pushl $0
80105e70:	6a 00                	push   $0x0
  pushl $49
80105e72:	6a 31                	push   $0x31
  jmp alltraps
80105e74:	e9 8e f9 ff ff       	jmp    80105807 <alltraps>

80105e79 <vector50>:
.globl vector50
vector50:
  pushl $0
80105e79:	6a 00                	push   $0x0
  pushl $50
80105e7b:	6a 32                	push   $0x32
  jmp alltraps
80105e7d:	e9 85 f9 ff ff       	jmp    80105807 <alltraps>

80105e82 <vector51>:
.globl vector51
vector51:
  pushl $0
80105e82:	6a 00                	push   $0x0
  pushl $51
80105e84:	6a 33                	push   $0x33
  jmp alltraps
80105e86:	e9 7c f9 ff ff       	jmp    80105807 <alltraps>

80105e8b <vector52>:
.globl vector52
vector52:
  pushl $0
80105e8b:	6a 00                	push   $0x0
  pushl $52
80105e8d:	6a 34                	push   $0x34
  jmp alltraps
80105e8f:	e9 73 f9 ff ff       	jmp    80105807 <alltraps>

80105e94 <vector53>:
.globl vector53
vector53:
  pushl $0
80105e94:	6a 00                	push   $0x0
  pushl $53
80105e96:	6a 35                	push   $0x35
  jmp alltraps
80105e98:	e9 6a f9 ff ff       	jmp    80105807 <alltraps>

80105e9d <vector54>:
.globl vector54
vector54:
  pushl $0
80105e9d:	6a 00                	push   $0x0
  pushl $54
80105e9f:	6a 36                	push   $0x36
  jmp alltraps
80105ea1:	e9 61 f9 ff ff       	jmp    80105807 <alltraps>

80105ea6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ea6:	6a 00                	push   $0x0
  pushl $55
80105ea8:	6a 37                	push   $0x37
  jmp alltraps
80105eaa:	e9 58 f9 ff ff       	jmp    80105807 <alltraps>

80105eaf <vector56>:
.globl vector56
vector56:
  pushl $0
80105eaf:	6a 00                	push   $0x0
  pushl $56
80105eb1:	6a 38                	push   $0x38
  jmp alltraps
80105eb3:	e9 4f f9 ff ff       	jmp    80105807 <alltraps>

80105eb8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105eb8:	6a 00                	push   $0x0
  pushl $57
80105eba:	6a 39                	push   $0x39
  jmp alltraps
80105ebc:	e9 46 f9 ff ff       	jmp    80105807 <alltraps>

80105ec1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ec1:	6a 00                	push   $0x0
  pushl $58
80105ec3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ec5:	e9 3d f9 ff ff       	jmp    80105807 <alltraps>

80105eca <vector59>:
.globl vector59
vector59:
  pushl $0
80105eca:	6a 00                	push   $0x0
  pushl $59
80105ecc:	6a 3b                	push   $0x3b
  jmp alltraps
80105ece:	e9 34 f9 ff ff       	jmp    80105807 <alltraps>

80105ed3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105ed3:	6a 00                	push   $0x0
  pushl $60
80105ed5:	6a 3c                	push   $0x3c
  jmp alltraps
80105ed7:	e9 2b f9 ff ff       	jmp    80105807 <alltraps>

80105edc <vector61>:
.globl vector61
vector61:
  pushl $0
80105edc:	6a 00                	push   $0x0
  pushl $61
80105ede:	6a 3d                	push   $0x3d
  jmp alltraps
80105ee0:	e9 22 f9 ff ff       	jmp    80105807 <alltraps>

80105ee5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105ee5:	6a 00                	push   $0x0
  pushl $62
80105ee7:	6a 3e                	push   $0x3e
  jmp alltraps
80105ee9:	e9 19 f9 ff ff       	jmp    80105807 <alltraps>

80105eee <vector63>:
.globl vector63
vector63:
  pushl $0
80105eee:	6a 00                	push   $0x0
  pushl $63
80105ef0:	6a 3f                	push   $0x3f
  jmp alltraps
80105ef2:	e9 10 f9 ff ff       	jmp    80105807 <alltraps>

80105ef7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105ef7:	6a 00                	push   $0x0
  pushl $64
80105ef9:	6a 40                	push   $0x40
  jmp alltraps
80105efb:	e9 07 f9 ff ff       	jmp    80105807 <alltraps>

80105f00 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f00:	6a 00                	push   $0x0
  pushl $65
80105f02:	6a 41                	push   $0x41
  jmp alltraps
80105f04:	e9 fe f8 ff ff       	jmp    80105807 <alltraps>

80105f09 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f09:	6a 00                	push   $0x0
  pushl $66
80105f0b:	6a 42                	push   $0x42
  jmp alltraps
80105f0d:	e9 f5 f8 ff ff       	jmp    80105807 <alltraps>

80105f12 <vector67>:
.globl vector67
vector67:
  pushl $0
80105f12:	6a 00                	push   $0x0
  pushl $67
80105f14:	6a 43                	push   $0x43
  jmp alltraps
80105f16:	e9 ec f8 ff ff       	jmp    80105807 <alltraps>

80105f1b <vector68>:
.globl vector68
vector68:
  pushl $0
80105f1b:	6a 00                	push   $0x0
  pushl $68
80105f1d:	6a 44                	push   $0x44
  jmp alltraps
80105f1f:	e9 e3 f8 ff ff       	jmp    80105807 <alltraps>

80105f24 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f24:	6a 00                	push   $0x0
  pushl $69
80105f26:	6a 45                	push   $0x45
  jmp alltraps
80105f28:	e9 da f8 ff ff       	jmp    80105807 <alltraps>

80105f2d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f2d:	6a 00                	push   $0x0
  pushl $70
80105f2f:	6a 46                	push   $0x46
  jmp alltraps
80105f31:	e9 d1 f8 ff ff       	jmp    80105807 <alltraps>

80105f36 <vector71>:
.globl vector71
vector71:
  pushl $0
80105f36:	6a 00                	push   $0x0
  pushl $71
80105f38:	6a 47                	push   $0x47
  jmp alltraps
80105f3a:	e9 c8 f8 ff ff       	jmp    80105807 <alltraps>

80105f3f <vector72>:
.globl vector72
vector72:
  pushl $0
80105f3f:	6a 00                	push   $0x0
  pushl $72
80105f41:	6a 48                	push   $0x48
  jmp alltraps
80105f43:	e9 bf f8 ff ff       	jmp    80105807 <alltraps>

80105f48 <vector73>:
.globl vector73
vector73:
  pushl $0
80105f48:	6a 00                	push   $0x0
  pushl $73
80105f4a:	6a 49                	push   $0x49
  jmp alltraps
80105f4c:	e9 b6 f8 ff ff       	jmp    80105807 <alltraps>

80105f51 <vector74>:
.globl vector74
vector74:
  pushl $0
80105f51:	6a 00                	push   $0x0
  pushl $74
80105f53:	6a 4a                	push   $0x4a
  jmp alltraps
80105f55:	e9 ad f8 ff ff       	jmp    80105807 <alltraps>

80105f5a <vector75>:
.globl vector75
vector75:
  pushl $0
80105f5a:	6a 00                	push   $0x0
  pushl $75
80105f5c:	6a 4b                	push   $0x4b
  jmp alltraps
80105f5e:	e9 a4 f8 ff ff       	jmp    80105807 <alltraps>

80105f63 <vector76>:
.globl vector76
vector76:
  pushl $0
80105f63:	6a 00                	push   $0x0
  pushl $76
80105f65:	6a 4c                	push   $0x4c
  jmp alltraps
80105f67:	e9 9b f8 ff ff       	jmp    80105807 <alltraps>

80105f6c <vector77>:
.globl vector77
vector77:
  pushl $0
80105f6c:	6a 00                	push   $0x0
  pushl $77
80105f6e:	6a 4d                	push   $0x4d
  jmp alltraps
80105f70:	e9 92 f8 ff ff       	jmp    80105807 <alltraps>

80105f75 <vector78>:
.globl vector78
vector78:
  pushl $0
80105f75:	6a 00                	push   $0x0
  pushl $78
80105f77:	6a 4e                	push   $0x4e
  jmp alltraps
80105f79:	e9 89 f8 ff ff       	jmp    80105807 <alltraps>

80105f7e <vector79>:
.globl vector79
vector79:
  pushl $0
80105f7e:	6a 00                	push   $0x0
  pushl $79
80105f80:	6a 4f                	push   $0x4f
  jmp alltraps
80105f82:	e9 80 f8 ff ff       	jmp    80105807 <alltraps>

80105f87 <vector80>:
.globl vector80
vector80:
  pushl $0
80105f87:	6a 00                	push   $0x0
  pushl $80
80105f89:	6a 50                	push   $0x50
  jmp alltraps
80105f8b:	e9 77 f8 ff ff       	jmp    80105807 <alltraps>

80105f90 <vector81>:
.globl vector81
vector81:
  pushl $0
80105f90:	6a 00                	push   $0x0
  pushl $81
80105f92:	6a 51                	push   $0x51
  jmp alltraps
80105f94:	e9 6e f8 ff ff       	jmp    80105807 <alltraps>

80105f99 <vector82>:
.globl vector82
vector82:
  pushl $0
80105f99:	6a 00                	push   $0x0
  pushl $82
80105f9b:	6a 52                	push   $0x52
  jmp alltraps
80105f9d:	e9 65 f8 ff ff       	jmp    80105807 <alltraps>

80105fa2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $83
80105fa4:	6a 53                	push   $0x53
  jmp alltraps
80105fa6:	e9 5c f8 ff ff       	jmp    80105807 <alltraps>

80105fab <vector84>:
.globl vector84
vector84:
  pushl $0
80105fab:	6a 00                	push   $0x0
  pushl $84
80105fad:	6a 54                	push   $0x54
  jmp alltraps
80105faf:	e9 53 f8 ff ff       	jmp    80105807 <alltraps>

80105fb4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105fb4:	6a 00                	push   $0x0
  pushl $85
80105fb6:	6a 55                	push   $0x55
  jmp alltraps
80105fb8:	e9 4a f8 ff ff       	jmp    80105807 <alltraps>

80105fbd <vector86>:
.globl vector86
vector86:
  pushl $0
80105fbd:	6a 00                	push   $0x0
  pushl $86
80105fbf:	6a 56                	push   $0x56
  jmp alltraps
80105fc1:	e9 41 f8 ff ff       	jmp    80105807 <alltraps>

80105fc6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $87
80105fc8:	6a 57                	push   $0x57
  jmp alltraps
80105fca:	e9 38 f8 ff ff       	jmp    80105807 <alltraps>

80105fcf <vector88>:
.globl vector88
vector88:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $88
80105fd1:	6a 58                	push   $0x58
  jmp alltraps
80105fd3:	e9 2f f8 ff ff       	jmp    80105807 <alltraps>

80105fd8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105fd8:	6a 00                	push   $0x0
  pushl $89
80105fda:	6a 59                	push   $0x59
  jmp alltraps
80105fdc:	e9 26 f8 ff ff       	jmp    80105807 <alltraps>

80105fe1 <vector90>:
.globl vector90
vector90:
  pushl $0
80105fe1:	6a 00                	push   $0x0
  pushl $90
80105fe3:	6a 5a                	push   $0x5a
  jmp alltraps
80105fe5:	e9 1d f8 ff ff       	jmp    80105807 <alltraps>

80105fea <vector91>:
.globl vector91
vector91:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $91
80105fec:	6a 5b                	push   $0x5b
  jmp alltraps
80105fee:	e9 14 f8 ff ff       	jmp    80105807 <alltraps>

80105ff3 <vector92>:
.globl vector92
vector92:
  pushl $0
80105ff3:	6a 00                	push   $0x0
  pushl $92
80105ff5:	6a 5c                	push   $0x5c
  jmp alltraps
80105ff7:	e9 0b f8 ff ff       	jmp    80105807 <alltraps>

80105ffc <vector93>:
.globl vector93
vector93:
  pushl $0
80105ffc:	6a 00                	push   $0x0
  pushl $93
80105ffe:	6a 5d                	push   $0x5d
  jmp alltraps
80106000:	e9 02 f8 ff ff       	jmp    80105807 <alltraps>

80106005 <vector94>:
.globl vector94
vector94:
  pushl $0
80106005:	6a 00                	push   $0x0
  pushl $94
80106007:	6a 5e                	push   $0x5e
  jmp alltraps
80106009:	e9 f9 f7 ff ff       	jmp    80105807 <alltraps>

8010600e <vector95>:
.globl vector95
vector95:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $95
80106010:	6a 5f                	push   $0x5f
  jmp alltraps
80106012:	e9 f0 f7 ff ff       	jmp    80105807 <alltraps>

80106017 <vector96>:
.globl vector96
vector96:
  pushl $0
80106017:	6a 00                	push   $0x0
  pushl $96
80106019:	6a 60                	push   $0x60
  jmp alltraps
8010601b:	e9 e7 f7 ff ff       	jmp    80105807 <alltraps>

80106020 <vector97>:
.globl vector97
vector97:
  pushl $0
80106020:	6a 00                	push   $0x0
  pushl $97
80106022:	6a 61                	push   $0x61
  jmp alltraps
80106024:	e9 de f7 ff ff       	jmp    80105807 <alltraps>

80106029 <vector98>:
.globl vector98
vector98:
  pushl $0
80106029:	6a 00                	push   $0x0
  pushl $98
8010602b:	6a 62                	push   $0x62
  jmp alltraps
8010602d:	e9 d5 f7 ff ff       	jmp    80105807 <alltraps>

80106032 <vector99>:
.globl vector99
vector99:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $99
80106034:	6a 63                	push   $0x63
  jmp alltraps
80106036:	e9 cc f7 ff ff       	jmp    80105807 <alltraps>

8010603b <vector100>:
.globl vector100
vector100:
  pushl $0
8010603b:	6a 00                	push   $0x0
  pushl $100
8010603d:	6a 64                	push   $0x64
  jmp alltraps
8010603f:	e9 c3 f7 ff ff       	jmp    80105807 <alltraps>

80106044 <vector101>:
.globl vector101
vector101:
  pushl $0
80106044:	6a 00                	push   $0x0
  pushl $101
80106046:	6a 65                	push   $0x65
  jmp alltraps
80106048:	e9 ba f7 ff ff       	jmp    80105807 <alltraps>

8010604d <vector102>:
.globl vector102
vector102:
  pushl $0
8010604d:	6a 00                	push   $0x0
  pushl $102
8010604f:	6a 66                	push   $0x66
  jmp alltraps
80106051:	e9 b1 f7 ff ff       	jmp    80105807 <alltraps>

80106056 <vector103>:
.globl vector103
vector103:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $103
80106058:	6a 67                	push   $0x67
  jmp alltraps
8010605a:	e9 a8 f7 ff ff       	jmp    80105807 <alltraps>

8010605f <vector104>:
.globl vector104
vector104:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $104
80106061:	6a 68                	push   $0x68
  jmp alltraps
80106063:	e9 9f f7 ff ff       	jmp    80105807 <alltraps>

80106068 <vector105>:
.globl vector105
vector105:
  pushl $0
80106068:	6a 00                	push   $0x0
  pushl $105
8010606a:	6a 69                	push   $0x69
  jmp alltraps
8010606c:	e9 96 f7 ff ff       	jmp    80105807 <alltraps>

80106071 <vector106>:
.globl vector106
vector106:
  pushl $0
80106071:	6a 00                	push   $0x0
  pushl $106
80106073:	6a 6a                	push   $0x6a
  jmp alltraps
80106075:	e9 8d f7 ff ff       	jmp    80105807 <alltraps>

8010607a <vector107>:
.globl vector107
vector107:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $107
8010607c:	6a 6b                	push   $0x6b
  jmp alltraps
8010607e:	e9 84 f7 ff ff       	jmp    80105807 <alltraps>

80106083 <vector108>:
.globl vector108
vector108:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $108
80106085:	6a 6c                	push   $0x6c
  jmp alltraps
80106087:	e9 7b f7 ff ff       	jmp    80105807 <alltraps>

8010608c <vector109>:
.globl vector109
vector109:
  pushl $0
8010608c:	6a 00                	push   $0x0
  pushl $109
8010608e:	6a 6d                	push   $0x6d
  jmp alltraps
80106090:	e9 72 f7 ff ff       	jmp    80105807 <alltraps>

80106095 <vector110>:
.globl vector110
vector110:
  pushl $0
80106095:	6a 00                	push   $0x0
  pushl $110
80106097:	6a 6e                	push   $0x6e
  jmp alltraps
80106099:	e9 69 f7 ff ff       	jmp    80105807 <alltraps>

8010609e <vector111>:
.globl vector111
vector111:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $111
801060a0:	6a 6f                	push   $0x6f
  jmp alltraps
801060a2:	e9 60 f7 ff ff       	jmp    80105807 <alltraps>

801060a7 <vector112>:
.globl vector112
vector112:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $112
801060a9:	6a 70                	push   $0x70
  jmp alltraps
801060ab:	e9 57 f7 ff ff       	jmp    80105807 <alltraps>

801060b0 <vector113>:
.globl vector113
vector113:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $113
801060b2:	6a 71                	push   $0x71
  jmp alltraps
801060b4:	e9 4e f7 ff ff       	jmp    80105807 <alltraps>

801060b9 <vector114>:
.globl vector114
vector114:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $114
801060bb:	6a 72                	push   $0x72
  jmp alltraps
801060bd:	e9 45 f7 ff ff       	jmp    80105807 <alltraps>

801060c2 <vector115>:
.globl vector115
vector115:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $115
801060c4:	6a 73                	push   $0x73
  jmp alltraps
801060c6:	e9 3c f7 ff ff       	jmp    80105807 <alltraps>

801060cb <vector116>:
.globl vector116
vector116:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $116
801060cd:	6a 74                	push   $0x74
  jmp alltraps
801060cf:	e9 33 f7 ff ff       	jmp    80105807 <alltraps>

801060d4 <vector117>:
.globl vector117
vector117:
  pushl $0
801060d4:	6a 00                	push   $0x0
  pushl $117
801060d6:	6a 75                	push   $0x75
  jmp alltraps
801060d8:	e9 2a f7 ff ff       	jmp    80105807 <alltraps>

801060dd <vector118>:
.globl vector118
vector118:
  pushl $0
801060dd:	6a 00                	push   $0x0
  pushl $118
801060df:	6a 76                	push   $0x76
  jmp alltraps
801060e1:	e9 21 f7 ff ff       	jmp    80105807 <alltraps>

801060e6 <vector119>:
.globl vector119
vector119:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $119
801060e8:	6a 77                	push   $0x77
  jmp alltraps
801060ea:	e9 18 f7 ff ff       	jmp    80105807 <alltraps>

801060ef <vector120>:
.globl vector120
vector120:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $120
801060f1:	6a 78                	push   $0x78
  jmp alltraps
801060f3:	e9 0f f7 ff ff       	jmp    80105807 <alltraps>

801060f8 <vector121>:
.globl vector121
vector121:
  pushl $0
801060f8:	6a 00                	push   $0x0
  pushl $121
801060fa:	6a 79                	push   $0x79
  jmp alltraps
801060fc:	e9 06 f7 ff ff       	jmp    80105807 <alltraps>

80106101 <vector122>:
.globl vector122
vector122:
  pushl $0
80106101:	6a 00                	push   $0x0
  pushl $122
80106103:	6a 7a                	push   $0x7a
  jmp alltraps
80106105:	e9 fd f6 ff ff       	jmp    80105807 <alltraps>

8010610a <vector123>:
.globl vector123
vector123:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $123
8010610c:	6a 7b                	push   $0x7b
  jmp alltraps
8010610e:	e9 f4 f6 ff ff       	jmp    80105807 <alltraps>

80106113 <vector124>:
.globl vector124
vector124:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $124
80106115:	6a 7c                	push   $0x7c
  jmp alltraps
80106117:	e9 eb f6 ff ff       	jmp    80105807 <alltraps>

8010611c <vector125>:
.globl vector125
vector125:
  pushl $0
8010611c:	6a 00                	push   $0x0
  pushl $125
8010611e:	6a 7d                	push   $0x7d
  jmp alltraps
80106120:	e9 e2 f6 ff ff       	jmp    80105807 <alltraps>

80106125 <vector126>:
.globl vector126
vector126:
  pushl $0
80106125:	6a 00                	push   $0x0
  pushl $126
80106127:	6a 7e                	push   $0x7e
  jmp alltraps
80106129:	e9 d9 f6 ff ff       	jmp    80105807 <alltraps>

8010612e <vector127>:
.globl vector127
vector127:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $127
80106130:	6a 7f                	push   $0x7f
  jmp alltraps
80106132:	e9 d0 f6 ff ff       	jmp    80105807 <alltraps>

80106137 <vector128>:
.globl vector128
vector128:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $128
80106139:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010613e:	e9 c4 f6 ff ff       	jmp    80105807 <alltraps>

80106143 <vector129>:
.globl vector129
vector129:
  pushl $0
80106143:	6a 00                	push   $0x0
  pushl $129
80106145:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010614a:	e9 b8 f6 ff ff       	jmp    80105807 <alltraps>

8010614f <vector130>:
.globl vector130
vector130:
  pushl $0
8010614f:	6a 00                	push   $0x0
  pushl $130
80106151:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106156:	e9 ac f6 ff ff       	jmp    80105807 <alltraps>

8010615b <vector131>:
.globl vector131
vector131:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $131
8010615d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106162:	e9 a0 f6 ff ff       	jmp    80105807 <alltraps>

80106167 <vector132>:
.globl vector132
vector132:
  pushl $0
80106167:	6a 00                	push   $0x0
  pushl $132
80106169:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010616e:	e9 94 f6 ff ff       	jmp    80105807 <alltraps>

80106173 <vector133>:
.globl vector133
vector133:
  pushl $0
80106173:	6a 00                	push   $0x0
  pushl $133
80106175:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010617a:	e9 88 f6 ff ff       	jmp    80105807 <alltraps>

8010617f <vector134>:
.globl vector134
vector134:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $134
80106181:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106186:	e9 7c f6 ff ff       	jmp    80105807 <alltraps>

8010618b <vector135>:
.globl vector135
vector135:
  pushl $0
8010618b:	6a 00                	push   $0x0
  pushl $135
8010618d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106192:	e9 70 f6 ff ff       	jmp    80105807 <alltraps>

80106197 <vector136>:
.globl vector136
vector136:
  pushl $0
80106197:	6a 00                	push   $0x0
  pushl $136
80106199:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010619e:	e9 64 f6 ff ff       	jmp    80105807 <alltraps>

801061a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $137
801061a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801061aa:	e9 58 f6 ff ff       	jmp    80105807 <alltraps>

801061af <vector138>:
.globl vector138
vector138:
  pushl $0
801061af:	6a 00                	push   $0x0
  pushl $138
801061b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801061b6:	e9 4c f6 ff ff       	jmp    80105807 <alltraps>

801061bb <vector139>:
.globl vector139
vector139:
  pushl $0
801061bb:	6a 00                	push   $0x0
  pushl $139
801061bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801061c2:	e9 40 f6 ff ff       	jmp    80105807 <alltraps>

801061c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $140
801061c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801061ce:	e9 34 f6 ff ff       	jmp    80105807 <alltraps>

801061d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801061d3:	6a 00                	push   $0x0
  pushl $141
801061d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801061da:	e9 28 f6 ff ff       	jmp    80105807 <alltraps>

801061df <vector142>:
.globl vector142
vector142:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $142
801061e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801061e6:	e9 1c f6 ff ff       	jmp    80105807 <alltraps>

801061eb <vector143>:
.globl vector143
vector143:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $143
801061ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801061f2:	e9 10 f6 ff ff       	jmp    80105807 <alltraps>

801061f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801061f7:	6a 00                	push   $0x0
  pushl $144
801061f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801061fe:	e9 04 f6 ff ff       	jmp    80105807 <alltraps>

80106203 <vector145>:
.globl vector145
vector145:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $145
80106205:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010620a:	e9 f8 f5 ff ff       	jmp    80105807 <alltraps>

8010620f <vector146>:
.globl vector146
vector146:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $146
80106211:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106216:	e9 ec f5 ff ff       	jmp    80105807 <alltraps>

8010621b <vector147>:
.globl vector147
vector147:
  pushl $0
8010621b:	6a 00                	push   $0x0
  pushl $147
8010621d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106222:	e9 e0 f5 ff ff       	jmp    80105807 <alltraps>

80106227 <vector148>:
.globl vector148
vector148:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $148
80106229:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010622e:	e9 d4 f5 ff ff       	jmp    80105807 <alltraps>

80106233 <vector149>:
.globl vector149
vector149:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $149
80106235:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010623a:	e9 c8 f5 ff ff       	jmp    80105807 <alltraps>

8010623f <vector150>:
.globl vector150
vector150:
  pushl $0
8010623f:	6a 00                	push   $0x0
  pushl $150
80106241:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106246:	e9 bc f5 ff ff       	jmp    80105807 <alltraps>

8010624b <vector151>:
.globl vector151
vector151:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $151
8010624d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106252:	e9 b0 f5 ff ff       	jmp    80105807 <alltraps>

80106257 <vector152>:
.globl vector152
vector152:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $152
80106259:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010625e:	e9 a4 f5 ff ff       	jmp    80105807 <alltraps>

80106263 <vector153>:
.globl vector153
vector153:
  pushl $0
80106263:	6a 00                	push   $0x0
  pushl $153
80106265:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010626a:	e9 98 f5 ff ff       	jmp    80105807 <alltraps>

8010626f <vector154>:
.globl vector154
vector154:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $154
80106271:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106276:	e9 8c f5 ff ff       	jmp    80105807 <alltraps>

8010627b <vector155>:
.globl vector155
vector155:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $155
8010627d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106282:	e9 80 f5 ff ff       	jmp    80105807 <alltraps>

80106287 <vector156>:
.globl vector156
vector156:
  pushl $0
80106287:	6a 00                	push   $0x0
  pushl $156
80106289:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010628e:	e9 74 f5 ff ff       	jmp    80105807 <alltraps>

80106293 <vector157>:
.globl vector157
vector157:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $157
80106295:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010629a:	e9 68 f5 ff ff       	jmp    80105807 <alltraps>

8010629f <vector158>:
.globl vector158
vector158:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $158
801062a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801062a6:	e9 5c f5 ff ff       	jmp    80105807 <alltraps>

801062ab <vector159>:
.globl vector159
vector159:
  pushl $0
801062ab:	6a 00                	push   $0x0
  pushl $159
801062ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801062b2:	e9 50 f5 ff ff       	jmp    80105807 <alltraps>

801062b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $160
801062b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801062be:	e9 44 f5 ff ff       	jmp    80105807 <alltraps>

801062c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $161
801062c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801062ca:	e9 38 f5 ff ff       	jmp    80105807 <alltraps>

801062cf <vector162>:
.globl vector162
vector162:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $162
801062d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801062d6:	e9 2c f5 ff ff       	jmp    80105807 <alltraps>

801062db <vector163>:
.globl vector163
vector163:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $163
801062dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801062e2:	e9 20 f5 ff ff       	jmp    80105807 <alltraps>

801062e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $164
801062e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801062ee:	e9 14 f5 ff ff       	jmp    80105807 <alltraps>

801062f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $165
801062f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801062fa:	e9 08 f5 ff ff       	jmp    80105807 <alltraps>

801062ff <vector166>:
.globl vector166
vector166:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $166
80106301:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106306:	e9 fc f4 ff ff       	jmp    80105807 <alltraps>

8010630b <vector167>:
.globl vector167
vector167:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $167
8010630d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106312:	e9 f0 f4 ff ff       	jmp    80105807 <alltraps>

80106317 <vector168>:
.globl vector168
vector168:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $168
80106319:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010631e:	e9 e4 f4 ff ff       	jmp    80105807 <alltraps>

80106323 <vector169>:
.globl vector169
vector169:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $169
80106325:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010632a:	e9 d8 f4 ff ff       	jmp    80105807 <alltraps>

8010632f <vector170>:
.globl vector170
vector170:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $170
80106331:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106336:	e9 cc f4 ff ff       	jmp    80105807 <alltraps>

8010633b <vector171>:
.globl vector171
vector171:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $171
8010633d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106342:	e9 c0 f4 ff ff       	jmp    80105807 <alltraps>

80106347 <vector172>:
.globl vector172
vector172:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $172
80106349:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010634e:	e9 b4 f4 ff ff       	jmp    80105807 <alltraps>

80106353 <vector173>:
.globl vector173
vector173:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $173
80106355:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010635a:	e9 a8 f4 ff ff       	jmp    80105807 <alltraps>

8010635f <vector174>:
.globl vector174
vector174:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $174
80106361:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106366:	e9 9c f4 ff ff       	jmp    80105807 <alltraps>

8010636b <vector175>:
.globl vector175
vector175:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $175
8010636d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106372:	e9 90 f4 ff ff       	jmp    80105807 <alltraps>

80106377 <vector176>:
.globl vector176
vector176:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $176
80106379:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010637e:	e9 84 f4 ff ff       	jmp    80105807 <alltraps>

80106383 <vector177>:
.globl vector177
vector177:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $177
80106385:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010638a:	e9 78 f4 ff ff       	jmp    80105807 <alltraps>

8010638f <vector178>:
.globl vector178
vector178:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $178
80106391:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106396:	e9 6c f4 ff ff       	jmp    80105807 <alltraps>

8010639b <vector179>:
.globl vector179
vector179:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $179
8010639d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801063a2:	e9 60 f4 ff ff       	jmp    80105807 <alltraps>

801063a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $180
801063a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801063ae:	e9 54 f4 ff ff       	jmp    80105807 <alltraps>

801063b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $181
801063b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801063ba:	e9 48 f4 ff ff       	jmp    80105807 <alltraps>

801063bf <vector182>:
.globl vector182
vector182:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $182
801063c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801063c6:	e9 3c f4 ff ff       	jmp    80105807 <alltraps>

801063cb <vector183>:
.globl vector183
vector183:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $183
801063cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801063d2:	e9 30 f4 ff ff       	jmp    80105807 <alltraps>

801063d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $184
801063d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801063de:	e9 24 f4 ff ff       	jmp    80105807 <alltraps>

801063e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $185
801063e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801063ea:	e9 18 f4 ff ff       	jmp    80105807 <alltraps>

801063ef <vector186>:
.globl vector186
vector186:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $186
801063f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801063f6:	e9 0c f4 ff ff       	jmp    80105807 <alltraps>

801063fb <vector187>:
.globl vector187
vector187:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $187
801063fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106402:	e9 00 f4 ff ff       	jmp    80105807 <alltraps>

80106407 <vector188>:
.globl vector188
vector188:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $188
80106409:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010640e:	e9 f4 f3 ff ff       	jmp    80105807 <alltraps>

80106413 <vector189>:
.globl vector189
vector189:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $189
80106415:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010641a:	e9 e8 f3 ff ff       	jmp    80105807 <alltraps>

8010641f <vector190>:
.globl vector190
vector190:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $190
80106421:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106426:	e9 dc f3 ff ff       	jmp    80105807 <alltraps>

8010642b <vector191>:
.globl vector191
vector191:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $191
8010642d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106432:	e9 d0 f3 ff ff       	jmp    80105807 <alltraps>

80106437 <vector192>:
.globl vector192
vector192:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $192
80106439:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010643e:	e9 c4 f3 ff ff       	jmp    80105807 <alltraps>

80106443 <vector193>:
.globl vector193
vector193:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $193
80106445:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010644a:	e9 b8 f3 ff ff       	jmp    80105807 <alltraps>

8010644f <vector194>:
.globl vector194
vector194:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $194
80106451:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106456:	e9 ac f3 ff ff       	jmp    80105807 <alltraps>

8010645b <vector195>:
.globl vector195
vector195:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $195
8010645d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106462:	e9 a0 f3 ff ff       	jmp    80105807 <alltraps>

80106467 <vector196>:
.globl vector196
vector196:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $196
80106469:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010646e:	e9 94 f3 ff ff       	jmp    80105807 <alltraps>

80106473 <vector197>:
.globl vector197
vector197:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $197
80106475:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010647a:	e9 88 f3 ff ff       	jmp    80105807 <alltraps>

8010647f <vector198>:
.globl vector198
vector198:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $198
80106481:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106486:	e9 7c f3 ff ff       	jmp    80105807 <alltraps>

8010648b <vector199>:
.globl vector199
vector199:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $199
8010648d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106492:	e9 70 f3 ff ff       	jmp    80105807 <alltraps>

80106497 <vector200>:
.globl vector200
vector200:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $200
80106499:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010649e:	e9 64 f3 ff ff       	jmp    80105807 <alltraps>

801064a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $201
801064a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801064aa:	e9 58 f3 ff ff       	jmp    80105807 <alltraps>

801064af <vector202>:
.globl vector202
vector202:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $202
801064b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801064b6:	e9 4c f3 ff ff       	jmp    80105807 <alltraps>

801064bb <vector203>:
.globl vector203
vector203:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $203
801064bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801064c2:	e9 40 f3 ff ff       	jmp    80105807 <alltraps>

801064c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $204
801064c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801064ce:	e9 34 f3 ff ff       	jmp    80105807 <alltraps>

801064d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $205
801064d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801064da:	e9 28 f3 ff ff       	jmp    80105807 <alltraps>

801064df <vector206>:
.globl vector206
vector206:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $206
801064e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801064e6:	e9 1c f3 ff ff       	jmp    80105807 <alltraps>

801064eb <vector207>:
.globl vector207
vector207:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $207
801064ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801064f2:	e9 10 f3 ff ff       	jmp    80105807 <alltraps>

801064f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $208
801064f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801064fe:	e9 04 f3 ff ff       	jmp    80105807 <alltraps>

80106503 <vector209>:
.globl vector209
vector209:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $209
80106505:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010650a:	e9 f8 f2 ff ff       	jmp    80105807 <alltraps>

8010650f <vector210>:
.globl vector210
vector210:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $210
80106511:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106516:	e9 ec f2 ff ff       	jmp    80105807 <alltraps>

8010651b <vector211>:
.globl vector211
vector211:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $211
8010651d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106522:	e9 e0 f2 ff ff       	jmp    80105807 <alltraps>

80106527 <vector212>:
.globl vector212
vector212:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $212
80106529:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010652e:	e9 d4 f2 ff ff       	jmp    80105807 <alltraps>

80106533 <vector213>:
.globl vector213
vector213:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $213
80106535:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010653a:	e9 c8 f2 ff ff       	jmp    80105807 <alltraps>

8010653f <vector214>:
.globl vector214
vector214:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $214
80106541:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106546:	e9 bc f2 ff ff       	jmp    80105807 <alltraps>

8010654b <vector215>:
.globl vector215
vector215:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $215
8010654d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106552:	e9 b0 f2 ff ff       	jmp    80105807 <alltraps>

80106557 <vector216>:
.globl vector216
vector216:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $216
80106559:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010655e:	e9 a4 f2 ff ff       	jmp    80105807 <alltraps>

80106563 <vector217>:
.globl vector217
vector217:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $217
80106565:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010656a:	e9 98 f2 ff ff       	jmp    80105807 <alltraps>

8010656f <vector218>:
.globl vector218
vector218:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $218
80106571:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106576:	e9 8c f2 ff ff       	jmp    80105807 <alltraps>

8010657b <vector219>:
.globl vector219
vector219:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $219
8010657d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106582:	e9 80 f2 ff ff       	jmp    80105807 <alltraps>

80106587 <vector220>:
.globl vector220
vector220:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $220
80106589:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010658e:	e9 74 f2 ff ff       	jmp    80105807 <alltraps>

80106593 <vector221>:
.globl vector221
vector221:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $221
80106595:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010659a:	e9 68 f2 ff ff       	jmp    80105807 <alltraps>

8010659f <vector222>:
.globl vector222
vector222:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $222
801065a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801065a6:	e9 5c f2 ff ff       	jmp    80105807 <alltraps>

801065ab <vector223>:
.globl vector223
vector223:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $223
801065ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801065b2:	e9 50 f2 ff ff       	jmp    80105807 <alltraps>

801065b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $224
801065b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801065be:	e9 44 f2 ff ff       	jmp    80105807 <alltraps>

801065c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $225
801065c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801065ca:	e9 38 f2 ff ff       	jmp    80105807 <alltraps>

801065cf <vector226>:
.globl vector226
vector226:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $226
801065d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801065d6:	e9 2c f2 ff ff       	jmp    80105807 <alltraps>

801065db <vector227>:
.globl vector227
vector227:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $227
801065dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801065e2:	e9 20 f2 ff ff       	jmp    80105807 <alltraps>

801065e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $228
801065e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801065ee:	e9 14 f2 ff ff       	jmp    80105807 <alltraps>

801065f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $229
801065f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801065fa:	e9 08 f2 ff ff       	jmp    80105807 <alltraps>

801065ff <vector230>:
.globl vector230
vector230:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $230
80106601:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106606:	e9 fc f1 ff ff       	jmp    80105807 <alltraps>

8010660b <vector231>:
.globl vector231
vector231:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $231
8010660d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106612:	e9 f0 f1 ff ff       	jmp    80105807 <alltraps>

80106617 <vector232>:
.globl vector232
vector232:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $232
80106619:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010661e:	e9 e4 f1 ff ff       	jmp    80105807 <alltraps>

80106623 <vector233>:
.globl vector233
vector233:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $233
80106625:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010662a:	e9 d8 f1 ff ff       	jmp    80105807 <alltraps>

8010662f <vector234>:
.globl vector234
vector234:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $234
80106631:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106636:	e9 cc f1 ff ff       	jmp    80105807 <alltraps>

8010663b <vector235>:
.globl vector235
vector235:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $235
8010663d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106642:	e9 c0 f1 ff ff       	jmp    80105807 <alltraps>

80106647 <vector236>:
.globl vector236
vector236:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $236
80106649:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010664e:	e9 b4 f1 ff ff       	jmp    80105807 <alltraps>

80106653 <vector237>:
.globl vector237
vector237:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $237
80106655:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010665a:	e9 a8 f1 ff ff       	jmp    80105807 <alltraps>

8010665f <vector238>:
.globl vector238
vector238:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $238
80106661:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106666:	e9 9c f1 ff ff       	jmp    80105807 <alltraps>

8010666b <vector239>:
.globl vector239
vector239:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $239
8010666d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106672:	e9 90 f1 ff ff       	jmp    80105807 <alltraps>

80106677 <vector240>:
.globl vector240
vector240:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $240
80106679:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010667e:	e9 84 f1 ff ff       	jmp    80105807 <alltraps>

80106683 <vector241>:
.globl vector241
vector241:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $241
80106685:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010668a:	e9 78 f1 ff ff       	jmp    80105807 <alltraps>

8010668f <vector242>:
.globl vector242
vector242:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $242
80106691:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106696:	e9 6c f1 ff ff       	jmp    80105807 <alltraps>

8010669b <vector243>:
.globl vector243
vector243:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $243
8010669d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801066a2:	e9 60 f1 ff ff       	jmp    80105807 <alltraps>

801066a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $244
801066a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801066ae:	e9 54 f1 ff ff       	jmp    80105807 <alltraps>

801066b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $245
801066b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801066ba:	e9 48 f1 ff ff       	jmp    80105807 <alltraps>

801066bf <vector246>:
.globl vector246
vector246:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $246
801066c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801066c6:	e9 3c f1 ff ff       	jmp    80105807 <alltraps>

801066cb <vector247>:
.globl vector247
vector247:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $247
801066cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801066d2:	e9 30 f1 ff ff       	jmp    80105807 <alltraps>

801066d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $248
801066d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801066de:	e9 24 f1 ff ff       	jmp    80105807 <alltraps>

801066e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $249
801066e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801066ea:	e9 18 f1 ff ff       	jmp    80105807 <alltraps>

801066ef <vector250>:
.globl vector250
vector250:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $250
801066f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801066f6:	e9 0c f1 ff ff       	jmp    80105807 <alltraps>

801066fb <vector251>:
.globl vector251
vector251:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $251
801066fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106702:	e9 00 f1 ff ff       	jmp    80105807 <alltraps>

80106707 <vector252>:
.globl vector252
vector252:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $252
80106709:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010670e:	e9 f4 f0 ff ff       	jmp    80105807 <alltraps>

80106713 <vector253>:
.globl vector253
vector253:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $253
80106715:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010671a:	e9 e8 f0 ff ff       	jmp    80105807 <alltraps>

8010671f <vector254>:
.globl vector254
vector254:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $254
80106721:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106726:	e9 dc f0 ff ff       	jmp    80105807 <alltraps>

8010672b <vector255>:
.globl vector255
vector255:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $255
8010672d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106732:	e9 d0 f0 ff ff       	jmp    80105807 <alltraps>
80106737:	66 90                	xchg   %ax,%ax
80106739:	66 90                	xchg   %ax,%ax
8010673b:	66 90                	xchg   %ax,%ax
8010673d:	66 90                	xchg   %ax,%ax
8010673f:	90                   	nop

80106740 <walkpgdir>:
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	57                   	push   %edi
80106744:	56                   	push   %esi
80106745:	53                   	push   %ebx
80106746:	89 d3                	mov    %edx,%ebx
80106748:	c1 ea 16             	shr    $0x16,%edx
8010674b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010674e:	83 ec 0c             	sub    $0xc,%esp
80106751:	8b 07                	mov    (%edi),%eax
80106753:	a8 01                	test   $0x1,%al
80106755:	74 29                	je     80106780 <walkpgdir+0x40>
80106757:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010675c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
80106762:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106765:	c1 eb 0a             	shr    $0xa,%ebx
80106768:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010676e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
80106771:	5b                   	pop    %ebx
80106772:	5e                   	pop    %esi
80106773:	5f                   	pop    %edi
80106774:	5d                   	pop    %ebp
80106775:	c3                   	ret    
80106776:	8d 76 00             	lea    0x0(%esi),%esi
80106779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106780:	85 c9                	test   %ecx,%ecx
80106782:	74 2c                	je     801067b0 <walkpgdir+0x70>
80106784:	e8 07 bd ff ff       	call   80102490 <kalloc>
80106789:	85 c0                	test   %eax,%eax
8010678b:	89 c6                	mov    %eax,%esi
8010678d:	74 21                	je     801067b0 <walkpgdir+0x70>
8010678f:	83 ec 04             	sub    $0x4,%esp
80106792:	68 00 10 00 00       	push   $0x1000
80106797:	6a 00                	push   $0x0
80106799:	50                   	push   %eax
8010679a:	e8 11 de ff ff       	call   801045b0 <memset>
8010679f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801067a5:	83 c4 10             	add    $0x10,%esp
801067a8:	83 c8 07             	or     $0x7,%eax
801067ab:	89 07                	mov    %eax,(%edi)
801067ad:	eb b3                	jmp    80106762 <walkpgdir+0x22>
801067af:	90                   	nop
801067b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067b3:	31 c0                	xor    %eax,%eax
801067b5:	5b                   	pop    %ebx
801067b6:	5e                   	pop    %esi
801067b7:	5f                   	pop    %edi
801067b8:	5d                   	pop    %ebp
801067b9:	c3                   	ret    
801067ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801067c0 <mappages>:
801067c0:	55                   	push   %ebp
801067c1:	89 e5                	mov    %esp,%ebp
801067c3:	57                   	push   %edi
801067c4:	56                   	push   %esi
801067c5:	53                   	push   %ebx
801067c6:	89 d3                	mov    %edx,%ebx
801067c8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801067ce:	83 ec 1c             	sub    $0x1c,%esp
801067d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801067d4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067d8:	8b 7d 08             	mov    0x8(%ebp),%edi
801067db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801067e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801067e6:	29 df                	sub    %ebx,%edi
801067e8:	83 c8 01             	or     $0x1,%eax
801067eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801067ee:	eb 15                	jmp    80106805 <mappages+0x45>
801067f0:	f6 00 01             	testb  $0x1,(%eax)
801067f3:	75 45                	jne    8010683a <mappages+0x7a>
801067f5:	0b 75 dc             	or     -0x24(%ebp),%esi
801067f8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
801067fb:	89 30                	mov    %esi,(%eax)
801067fd:	74 31                	je     80106830 <mappages+0x70>
801067ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106805:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106808:	b9 01 00 00 00       	mov    $0x1,%ecx
8010680d:	89 da                	mov    %ebx,%edx
8010680f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106812:	e8 29 ff ff ff       	call   80106740 <walkpgdir>
80106817:	85 c0                	test   %eax,%eax
80106819:	75 d5                	jne    801067f0 <mappages+0x30>
8010681b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010681e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106823:	5b                   	pop    %ebx
80106824:	5e                   	pop    %esi
80106825:	5f                   	pop    %edi
80106826:	5d                   	pop    %ebp
80106827:	c3                   	ret    
80106828:	90                   	nop
80106829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106830:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106833:	31 c0                	xor    %eax,%eax
80106835:	5b                   	pop    %ebx
80106836:	5e                   	pop    %esi
80106837:	5f                   	pop    %edi
80106838:	5d                   	pop    %ebp
80106839:	c3                   	ret    
8010683a:	83 ec 0c             	sub    $0xc,%esp
8010683d:	68 10 7a 10 80       	push   $0x80107a10
80106842:	e8 29 9b ff ff       	call   80100370 <panic>
80106847:	89 f6                	mov    %esi,%esi
80106849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106850 <deallocuvm.part.0>:
80106850:	55                   	push   %ebp
80106851:	89 e5                	mov    %esp,%ebp
80106853:	57                   	push   %edi
80106854:	56                   	push   %esi
80106855:	53                   	push   %ebx
80106856:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010685c:	89 c7                	mov    %eax,%edi
8010685e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106864:	83 ec 1c             	sub    $0x1c,%esp
80106867:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010686a:	39 d3                	cmp    %edx,%ebx
8010686c:	73 66                	jae    801068d4 <deallocuvm.part.0+0x84>
8010686e:	89 d6                	mov    %edx,%esi
80106870:	eb 3d                	jmp    801068af <deallocuvm.part.0+0x5f>
80106872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106878:	8b 10                	mov    (%eax),%edx
8010687a:	f6 c2 01             	test   $0x1,%dl
8010687d:	74 26                	je     801068a5 <deallocuvm.part.0+0x55>
8010687f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106885:	74 58                	je     801068df <deallocuvm.part.0+0x8f>
80106887:	83 ec 0c             	sub    $0xc,%esp
8010688a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106890:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106893:	52                   	push   %edx
80106894:	e8 47 ba ff ff       	call   801022e0 <kfree>
80106899:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010689c:	83 c4 10             	add    $0x10,%esp
8010689f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801068a5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068ab:	39 f3                	cmp    %esi,%ebx
801068ad:	73 25                	jae    801068d4 <deallocuvm.part.0+0x84>
801068af:	31 c9                	xor    %ecx,%ecx
801068b1:	89 da                	mov    %ebx,%edx
801068b3:	89 f8                	mov    %edi,%eax
801068b5:	e8 86 fe ff ff       	call   80106740 <walkpgdir>
801068ba:	85 c0                	test   %eax,%eax
801068bc:	75 ba                	jne    80106878 <deallocuvm.part.0+0x28>
801068be:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801068c4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
801068ca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068d0:	39 f3                	cmp    %esi,%ebx
801068d2:	72 db                	jb     801068af <deallocuvm.part.0+0x5f>
801068d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068da:	5b                   	pop    %ebx
801068db:	5e                   	pop    %esi
801068dc:	5f                   	pop    %edi
801068dd:	5d                   	pop    %ebp
801068de:	c3                   	ret    
801068df:	83 ec 0c             	sub    $0xc,%esp
801068e2:	68 26 73 10 80       	push   $0x80107326
801068e7:	e8 84 9a ff ff       	call   80100370 <panic>
801068ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068f0 <seginit>:
801068f0:	55                   	push   %ebp
801068f1:	89 e5                	mov    %esp,%ebp
801068f3:	83 ec 18             	sub    $0x18,%esp
801068f6:	e8 75 ce ff ff       	call   80103770 <cpuid>
801068fb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106901:	31 c9                	xor    %ecx,%ecx
80106903:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106908:	66 89 90 f8 27 11 80 	mov    %dx,-0x7feed808(%eax)
8010690f:	66 89 88 fa 27 11 80 	mov    %cx,-0x7feed806(%eax)
80106916:	ba ff ff ff ff       	mov    $0xffffffff,%edx
8010691b:	31 c9                	xor    %ecx,%ecx
8010691d:	66 89 90 00 28 11 80 	mov    %dx,-0x7feed800(%eax)
80106924:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106929:	66 89 88 02 28 11 80 	mov    %cx,-0x7feed7fe(%eax)
80106930:	31 c9                	xor    %ecx,%ecx
80106932:	66 89 90 08 28 11 80 	mov    %dx,-0x7feed7f8(%eax)
80106939:	66 89 88 0a 28 11 80 	mov    %cx,-0x7feed7f6(%eax)
80106940:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106945:	31 c9                	xor    %ecx,%ecx
80106947:	66 89 90 10 28 11 80 	mov    %dx,-0x7feed7f0(%eax)
8010694e:	c6 80 fc 27 11 80 00 	movb   $0x0,-0x7feed804(%eax)
80106955:	ba 2f 00 00 00       	mov    $0x2f,%edx
8010695a:	c6 80 fd 27 11 80 9a 	movb   $0x9a,-0x7feed803(%eax)
80106961:	c6 80 fe 27 11 80 cf 	movb   $0xcf,-0x7feed802(%eax)
80106968:	c6 80 ff 27 11 80 00 	movb   $0x0,-0x7feed801(%eax)
8010696f:	c6 80 04 28 11 80 00 	movb   $0x0,-0x7feed7fc(%eax)
80106976:	c6 80 05 28 11 80 92 	movb   $0x92,-0x7feed7fb(%eax)
8010697d:	c6 80 06 28 11 80 cf 	movb   $0xcf,-0x7feed7fa(%eax)
80106984:	c6 80 07 28 11 80 00 	movb   $0x0,-0x7feed7f9(%eax)
8010698b:	c6 80 0c 28 11 80 00 	movb   $0x0,-0x7feed7f4(%eax)
80106992:	c6 80 0d 28 11 80 fa 	movb   $0xfa,-0x7feed7f3(%eax)
80106999:	c6 80 0e 28 11 80 cf 	movb   $0xcf,-0x7feed7f2(%eax)
801069a0:	c6 80 0f 28 11 80 00 	movb   $0x0,-0x7feed7f1(%eax)
801069a7:	66 89 88 12 28 11 80 	mov    %cx,-0x7feed7ee(%eax)
801069ae:	c6 80 14 28 11 80 00 	movb   $0x0,-0x7feed7ec(%eax)
801069b5:	c6 80 15 28 11 80 f2 	movb   $0xf2,-0x7feed7eb(%eax)
801069bc:	c6 80 16 28 11 80 cf 	movb   $0xcf,-0x7feed7ea(%eax)
801069c3:	c6 80 17 28 11 80 00 	movb   $0x0,-0x7feed7e9(%eax)
801069ca:	05 f0 27 11 80       	add    $0x801127f0,%eax
801069cf:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
801069d3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
801069d7:	c1 e8 10             	shr    $0x10,%eax
801069da:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
801069de:	8d 45 f2             	lea    -0xe(%ebp),%eax
801069e1:	0f 01 10             	lgdtl  (%eax)
801069e4:	c9                   	leave  
801069e5:	c3                   	ret    
801069e6:	8d 76 00             	lea    0x0(%esi),%esi
801069e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069f0 <switchkvm>:
801069f0:	a1 a4 55 11 80       	mov    0x801155a4,%eax
801069f5:	55                   	push   %ebp
801069f6:	89 e5                	mov    %esp,%ebp
801069f8:	05 00 00 00 80       	add    $0x80000000,%eax
801069fd:	0f 22 d8             	mov    %eax,%cr3
80106a00:	5d                   	pop    %ebp
80106a01:	c3                   	ret    
80106a02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a10 <switchuvm>:
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	56                   	push   %esi
80106a15:	53                   	push   %ebx
80106a16:	83 ec 1c             	sub    $0x1c,%esp
80106a19:	8b 75 08             	mov    0x8(%ebp),%esi
80106a1c:	85 f6                	test   %esi,%esi
80106a1e:	0f 84 cd 00 00 00    	je     80106af1 <switchuvm+0xe1>
80106a24:	8b 46 08             	mov    0x8(%esi),%eax
80106a27:	85 c0                	test   %eax,%eax
80106a29:	0f 84 dc 00 00 00    	je     80106b0b <switchuvm+0xfb>
80106a2f:	8b 7e 04             	mov    0x4(%esi),%edi
80106a32:	85 ff                	test   %edi,%edi
80106a34:	0f 84 c4 00 00 00    	je     80106afe <switchuvm+0xee>
80106a3a:	e8 c1 d9 ff ff       	call   80104400 <pushcli>
80106a3f:	e8 ac cc ff ff       	call   801036f0 <mycpu>
80106a44:	89 c3                	mov    %eax,%ebx
80106a46:	e8 a5 cc ff ff       	call   801036f0 <mycpu>
80106a4b:	89 c7                	mov    %eax,%edi
80106a4d:	e8 9e cc ff ff       	call   801036f0 <mycpu>
80106a52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a55:	83 c7 08             	add    $0x8,%edi
80106a58:	e8 93 cc ff ff       	call   801036f0 <mycpu>
80106a5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a60:	83 c0 08             	add    $0x8,%eax
80106a63:	ba 67 00 00 00       	mov    $0x67,%edx
80106a68:	c1 e8 18             	shr    $0x18,%eax
80106a6b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106a72:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106a79:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106a80:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106a87:	83 c1 08             	add    $0x8,%ecx
80106a8a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106a90:	c1 e9 10             	shr    $0x10,%ecx
80106a93:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106a99:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106a9e:	e8 4d cc ff ff       	call   801036f0 <mycpu>
80106aa3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
80106aaa:	e8 41 cc ff ff       	call   801036f0 <mycpu>
80106aaf:	b9 10 00 00 00       	mov    $0x10,%ecx
80106ab4:	66 89 48 10          	mov    %cx,0x10(%eax)
80106ab8:	e8 33 cc ff ff       	call   801036f0 <mycpu>
80106abd:	8b 56 08             	mov    0x8(%esi),%edx
80106ac0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106ac6:	89 48 0c             	mov    %ecx,0xc(%eax)
80106ac9:	e8 22 cc ff ff       	call   801036f0 <mycpu>
80106ace:	66 89 58 6e          	mov    %bx,0x6e(%eax)
80106ad2:	b8 28 00 00 00       	mov    $0x28,%eax
80106ad7:	0f 00 d8             	ltr    %ax
80106ada:	8b 46 04             	mov    0x4(%esi),%eax
80106add:	05 00 00 00 80       	add    $0x80000000,%eax
80106ae2:	0f 22 d8             	mov    %eax,%cr3
80106ae5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ae8:	5b                   	pop    %ebx
80106ae9:	5e                   	pop    %esi
80106aea:	5f                   	pop    %edi
80106aeb:	5d                   	pop    %ebp
80106aec:	e9 ff d9 ff ff       	jmp    801044f0 <popcli>
80106af1:	83 ec 0c             	sub    $0xc,%esp
80106af4:	68 16 7a 10 80       	push   $0x80107a16
80106af9:	e8 72 98 ff ff       	call   80100370 <panic>
80106afe:	83 ec 0c             	sub    $0xc,%esp
80106b01:	68 41 7a 10 80       	push   $0x80107a41
80106b06:	e8 65 98 ff ff       	call   80100370 <panic>
80106b0b:	83 ec 0c             	sub    $0xc,%esp
80106b0e:	68 2c 7a 10 80       	push   $0x80107a2c
80106b13:	e8 58 98 ff ff       	call   80100370 <panic>
80106b18:	90                   	nop
80106b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b20 <inituvm>:
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	57                   	push   %edi
80106b24:	56                   	push   %esi
80106b25:	53                   	push   %ebx
80106b26:	83 ec 1c             	sub    $0x1c,%esp
80106b29:	8b 75 10             	mov    0x10(%ebp),%esi
80106b2c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b2f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106b32:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106b38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b3b:	77 49                	ja     80106b86 <inituvm+0x66>
80106b3d:	e8 4e b9 ff ff       	call   80102490 <kalloc>
80106b42:	83 ec 04             	sub    $0x4,%esp
80106b45:	89 c3                	mov    %eax,%ebx
80106b47:	68 00 10 00 00       	push   $0x1000
80106b4c:	6a 00                	push   $0x0
80106b4e:	50                   	push   %eax
80106b4f:	e8 5c da ff ff       	call   801045b0 <memset>
80106b54:	58                   	pop    %eax
80106b55:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b5b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b60:	5a                   	pop    %edx
80106b61:	6a 06                	push   $0x6
80106b63:	50                   	push   %eax
80106b64:	31 d2                	xor    %edx,%edx
80106b66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b69:	e8 52 fc ff ff       	call   801067c0 <mappages>
80106b6e:	89 75 10             	mov    %esi,0x10(%ebp)
80106b71:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b74:	83 c4 10             	add    $0x10,%esp
80106b77:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106b7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b7d:	5b                   	pop    %ebx
80106b7e:	5e                   	pop    %esi
80106b7f:	5f                   	pop    %edi
80106b80:	5d                   	pop    %ebp
80106b81:	e9 da da ff ff       	jmp    80104660 <memmove>
80106b86:	83 ec 0c             	sub    $0xc,%esp
80106b89:	68 55 7a 10 80       	push   $0x80107a55
80106b8e:	e8 dd 97 ff ff       	call   80100370 <panic>
80106b93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ba0 <loaduvm>:
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	57                   	push   %edi
80106ba4:	56                   	push   %esi
80106ba5:	53                   	push   %ebx
80106ba6:	83 ec 0c             	sub    $0xc,%esp
80106ba9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106bb0:	0f 85 91 00 00 00    	jne    80106c47 <loaduvm+0xa7>
80106bb6:	8b 75 18             	mov    0x18(%ebp),%esi
80106bb9:	31 db                	xor    %ebx,%ebx
80106bbb:	85 f6                	test   %esi,%esi
80106bbd:	75 1a                	jne    80106bd9 <loaduvm+0x39>
80106bbf:	eb 6f                	jmp    80106c30 <loaduvm+0x90>
80106bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bc8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106bd4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106bd7:	76 57                	jbe    80106c30 <loaduvm+0x90>
80106bd9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bdc:	8b 45 08             	mov    0x8(%ebp),%eax
80106bdf:	31 c9                	xor    %ecx,%ecx
80106be1:	01 da                	add    %ebx,%edx
80106be3:	e8 58 fb ff ff       	call   80106740 <walkpgdir>
80106be8:	85 c0                	test   %eax,%eax
80106bea:	74 4e                	je     80106c3a <loaduvm+0x9a>
80106bec:	8b 00                	mov    (%eax),%eax
80106bee:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106bf1:	bf 00 10 00 00       	mov    $0x1000,%edi
80106bf6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106bfb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106c01:	0f 46 fe             	cmovbe %esi,%edi
80106c04:	01 d9                	add    %ebx,%ecx
80106c06:	05 00 00 00 80       	add    $0x80000000,%eax
80106c0b:	57                   	push   %edi
80106c0c:	51                   	push   %ecx
80106c0d:	50                   	push   %eax
80106c0e:	ff 75 10             	pushl  0x10(%ebp)
80106c11:	e8 3a ad ff ff       	call   80101950 <readi>
80106c16:	83 c4 10             	add    $0x10,%esp
80106c19:	39 c7                	cmp    %eax,%edi
80106c1b:	74 ab                	je     80106bc8 <loaduvm+0x28>
80106c1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c25:	5b                   	pop    %ebx
80106c26:	5e                   	pop    %esi
80106c27:	5f                   	pop    %edi
80106c28:	5d                   	pop    %ebp
80106c29:	c3                   	ret    
80106c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c33:	31 c0                	xor    %eax,%eax
80106c35:	5b                   	pop    %ebx
80106c36:	5e                   	pop    %esi
80106c37:	5f                   	pop    %edi
80106c38:	5d                   	pop    %ebp
80106c39:	c3                   	ret    
80106c3a:	83 ec 0c             	sub    $0xc,%esp
80106c3d:	68 6f 7a 10 80       	push   $0x80107a6f
80106c42:	e8 29 97 ff ff       	call   80100370 <panic>
80106c47:	83 ec 0c             	sub    $0xc,%esp
80106c4a:	68 10 7b 10 80       	push   $0x80107b10
80106c4f:	e8 1c 97 ff ff       	call   80100370 <panic>
80106c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c60 <allocuvm>:
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 0c             	sub    $0xc,%esp
80106c69:	8b 7d 10             	mov    0x10(%ebp),%edi
80106c6c:	85 ff                	test   %edi,%edi
80106c6e:	0f 88 ca 00 00 00    	js     80106d3e <allocuvm+0xde>
80106c74:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c77:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c7a:	0f 82 82 00 00 00    	jb     80106d02 <allocuvm+0xa2>
80106c80:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c86:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106c8c:	39 df                	cmp    %ebx,%edi
80106c8e:	77 43                	ja     80106cd3 <allocuvm+0x73>
80106c90:	e9 bb 00 00 00       	jmp    80106d50 <allocuvm+0xf0>
80106c95:	8d 76 00             	lea    0x0(%esi),%esi
80106c98:	83 ec 04             	sub    $0x4,%esp
80106c9b:	68 00 10 00 00       	push   $0x1000
80106ca0:	6a 00                	push   $0x0
80106ca2:	50                   	push   %eax
80106ca3:	e8 08 d9 ff ff       	call   801045b0 <memset>
80106ca8:	58                   	pop    %eax
80106ca9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106caf:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106cb4:	5a                   	pop    %edx
80106cb5:	6a 06                	push   $0x6
80106cb7:	50                   	push   %eax
80106cb8:	89 da                	mov    %ebx,%edx
80106cba:	8b 45 08             	mov    0x8(%ebp),%eax
80106cbd:	e8 fe fa ff ff       	call   801067c0 <mappages>
80106cc2:	83 c4 10             	add    $0x10,%esp
80106cc5:	85 c0                	test   %eax,%eax
80106cc7:	78 47                	js     80106d10 <allocuvm+0xb0>
80106cc9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ccf:	39 df                	cmp    %ebx,%edi
80106cd1:	76 7d                	jbe    80106d50 <allocuvm+0xf0>
80106cd3:	e8 b8 b7 ff ff       	call   80102490 <kalloc>
80106cd8:	85 c0                	test   %eax,%eax
80106cda:	89 c6                	mov    %eax,%esi
80106cdc:	75 ba                	jne    80106c98 <allocuvm+0x38>
80106cde:	83 ec 0c             	sub    $0xc,%esp
80106ce1:	68 8d 7a 10 80       	push   $0x80107a8d
80106ce6:	e8 75 99 ff ff       	call   80100660 <cprintf>
80106ceb:	83 c4 10             	add    $0x10,%esp
80106cee:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106cf1:	76 4b                	jbe    80106d3e <allocuvm+0xde>
80106cf3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106cf6:	8b 45 08             	mov    0x8(%ebp),%eax
80106cf9:	89 fa                	mov    %edi,%edx
80106cfb:	e8 50 fb ff ff       	call   80106850 <deallocuvm.part.0>
80106d00:	31 c0                	xor    %eax,%eax
80106d02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d05:	5b                   	pop    %ebx
80106d06:	5e                   	pop    %esi
80106d07:	5f                   	pop    %edi
80106d08:	5d                   	pop    %ebp
80106d09:	c3                   	ret    
80106d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d10:	83 ec 0c             	sub    $0xc,%esp
80106d13:	68 a5 7a 10 80       	push   $0x80107aa5
80106d18:	e8 43 99 ff ff       	call   80100660 <cprintf>
80106d1d:	83 c4 10             	add    $0x10,%esp
80106d20:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106d23:	76 0d                	jbe    80106d32 <allocuvm+0xd2>
80106d25:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106d28:	8b 45 08             	mov    0x8(%ebp),%eax
80106d2b:	89 fa                	mov    %edi,%edx
80106d2d:	e8 1e fb ff ff       	call   80106850 <deallocuvm.part.0>
80106d32:	83 ec 0c             	sub    $0xc,%esp
80106d35:	56                   	push   %esi
80106d36:	e8 a5 b5 ff ff       	call   801022e0 <kfree>
80106d3b:	83 c4 10             	add    $0x10,%esp
80106d3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d41:	31 c0                	xor    %eax,%eax
80106d43:	5b                   	pop    %ebx
80106d44:	5e                   	pop    %esi
80106d45:	5f                   	pop    %edi
80106d46:	5d                   	pop    %ebp
80106d47:	c3                   	ret    
80106d48:	90                   	nop
80106d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d53:	89 f8                	mov    %edi,%eax
80106d55:	5b                   	pop    %ebx
80106d56:	5e                   	pop    %esi
80106d57:	5f                   	pop    %edi
80106d58:	5d                   	pop    %ebp
80106d59:	c3                   	ret    
80106d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d60 <deallocuvm>:
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d66:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d69:	8b 45 08             	mov    0x8(%ebp),%eax
80106d6c:	39 d1                	cmp    %edx,%ecx
80106d6e:	73 10                	jae    80106d80 <deallocuvm+0x20>
80106d70:	5d                   	pop    %ebp
80106d71:	e9 da fa ff ff       	jmp    80106850 <deallocuvm.part.0>
80106d76:	8d 76 00             	lea    0x0(%esi),%esi
80106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d80:	89 d0                	mov    %edx,%eax
80106d82:	5d                   	pop    %ebp
80106d83:	c3                   	ret    
80106d84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d90 <freevm>:
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
80106d96:	83 ec 0c             	sub    $0xc,%esp
80106d99:	8b 75 08             	mov    0x8(%ebp),%esi
80106d9c:	85 f6                	test   %esi,%esi
80106d9e:	74 59                	je     80106df9 <freevm+0x69>
80106da0:	31 c9                	xor    %ecx,%ecx
80106da2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106da7:	89 f0                	mov    %esi,%eax
80106da9:	e8 a2 fa ff ff       	call   80106850 <deallocuvm.part.0>
80106dae:	89 f3                	mov    %esi,%ebx
80106db0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106db6:	eb 0f                	jmp    80106dc7 <freevm+0x37>
80106db8:	90                   	nop
80106db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dc0:	83 c3 04             	add    $0x4,%ebx
80106dc3:	39 fb                	cmp    %edi,%ebx
80106dc5:	74 23                	je     80106dea <freevm+0x5a>
80106dc7:	8b 03                	mov    (%ebx),%eax
80106dc9:	a8 01                	test   $0x1,%al
80106dcb:	74 f3                	je     80106dc0 <freevm+0x30>
80106dcd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106dd2:	83 ec 0c             	sub    $0xc,%esp
80106dd5:	83 c3 04             	add    $0x4,%ebx
80106dd8:	05 00 00 00 80       	add    $0x80000000,%eax
80106ddd:	50                   	push   %eax
80106dde:	e8 fd b4 ff ff       	call   801022e0 <kfree>
80106de3:	83 c4 10             	add    $0x10,%esp
80106de6:	39 fb                	cmp    %edi,%ebx
80106de8:	75 dd                	jne    80106dc7 <freevm+0x37>
80106dea:	89 75 08             	mov    %esi,0x8(%ebp)
80106ded:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106df0:	5b                   	pop    %ebx
80106df1:	5e                   	pop    %esi
80106df2:	5f                   	pop    %edi
80106df3:	5d                   	pop    %ebp
80106df4:	e9 e7 b4 ff ff       	jmp    801022e0 <kfree>
80106df9:	83 ec 0c             	sub    $0xc,%esp
80106dfc:	68 c1 7a 10 80       	push   $0x80107ac1
80106e01:	e8 6a 95 ff ff       	call   80100370 <panic>
80106e06:	8d 76 00             	lea    0x0(%esi),%esi
80106e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e10 <setupkvm>:
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	56                   	push   %esi
80106e14:	53                   	push   %ebx
80106e15:	e8 76 b6 ff ff       	call   80102490 <kalloc>
80106e1a:	85 c0                	test   %eax,%eax
80106e1c:	74 6a                	je     80106e88 <setupkvm+0x78>
80106e1e:	83 ec 04             	sub    $0x4,%esp
80106e21:	89 c6                	mov    %eax,%esi
80106e23:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
80106e28:	68 00 10 00 00       	push   $0x1000
80106e2d:	6a 00                	push   $0x0
80106e2f:	50                   	push   %eax
80106e30:	e8 7b d7 ff ff       	call   801045b0 <memset>
80106e35:	83 c4 10             	add    $0x10,%esp
80106e38:	8b 43 04             	mov    0x4(%ebx),%eax
80106e3b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e3e:	83 ec 08             	sub    $0x8,%esp
80106e41:	8b 13                	mov    (%ebx),%edx
80106e43:	ff 73 0c             	pushl  0xc(%ebx)
80106e46:	50                   	push   %eax
80106e47:	29 c1                	sub    %eax,%ecx
80106e49:	89 f0                	mov    %esi,%eax
80106e4b:	e8 70 f9 ff ff       	call   801067c0 <mappages>
80106e50:	83 c4 10             	add    $0x10,%esp
80106e53:	85 c0                	test   %eax,%eax
80106e55:	78 19                	js     80106e70 <setupkvm+0x60>
80106e57:	83 c3 10             	add    $0x10,%ebx
80106e5a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e60:	75 d6                	jne    80106e38 <setupkvm+0x28>
80106e62:	89 f0                	mov    %esi,%eax
80106e64:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e67:	5b                   	pop    %ebx
80106e68:	5e                   	pop    %esi
80106e69:	5d                   	pop    %ebp
80106e6a:	c3                   	ret    
80106e6b:	90                   	nop
80106e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e70:	83 ec 0c             	sub    $0xc,%esp
80106e73:	56                   	push   %esi
80106e74:	e8 17 ff ff ff       	call   80106d90 <freevm>
80106e79:	83 c4 10             	add    $0x10,%esp
80106e7c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e7f:	31 c0                	xor    %eax,%eax
80106e81:	5b                   	pop    %ebx
80106e82:	5e                   	pop    %esi
80106e83:	5d                   	pop    %ebp
80106e84:	c3                   	ret    
80106e85:	8d 76 00             	lea    0x0(%esi),%esi
80106e88:	31 c0                	xor    %eax,%eax
80106e8a:	eb d8                	jmp    80106e64 <setupkvm+0x54>
80106e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e90 <kvmalloc>:
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	83 ec 08             	sub    $0x8,%esp
80106e96:	e8 75 ff ff ff       	call   80106e10 <setupkvm>
80106e9b:	a3 a4 55 11 80       	mov    %eax,0x801155a4
80106ea0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ea5:	0f 22 d8             	mov    %eax,%cr3
80106ea8:	c9                   	leave  
80106ea9:	c3                   	ret    
80106eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106eb0 <clearpteu>:
80106eb0:	55                   	push   %ebp
80106eb1:	31 c9                	xor    %ecx,%ecx
80106eb3:	89 e5                	mov    %esp,%ebp
80106eb5:	83 ec 08             	sub    $0x8,%esp
80106eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ebb:	8b 45 08             	mov    0x8(%ebp),%eax
80106ebe:	e8 7d f8 ff ff       	call   80106740 <walkpgdir>
80106ec3:	85 c0                	test   %eax,%eax
80106ec5:	74 05                	je     80106ecc <clearpteu+0x1c>
80106ec7:	83 20 fb             	andl   $0xfffffffb,(%eax)
80106eca:	c9                   	leave  
80106ecb:	c3                   	ret    
80106ecc:	83 ec 0c             	sub    $0xc,%esp
80106ecf:	68 d2 7a 10 80       	push   $0x80107ad2
80106ed4:	e8 97 94 ff ff       	call   80100370 <panic>
80106ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ee0 <copyuvm>:
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	57                   	push   %edi
80106ee4:	56                   	push   %esi
80106ee5:	53                   	push   %ebx
80106ee6:	83 ec 1c             	sub    $0x1c,%esp
80106ee9:	e8 22 ff ff ff       	call   80106e10 <setupkvm>
80106eee:	85 c0                	test   %eax,%eax
80106ef0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ef3:	0f 84 b2 00 00 00    	je     80106fab <copyuvm+0xcb>
80106ef9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106efc:	85 c9                	test   %ecx,%ecx
80106efe:	0f 84 9c 00 00 00    	je     80106fa0 <copyuvm+0xc0>
80106f04:	31 f6                	xor    %esi,%esi
80106f06:	eb 4a                	jmp    80106f52 <copyuvm+0x72>
80106f08:	90                   	nop
80106f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f10:	83 ec 04             	sub    $0x4,%esp
80106f13:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106f19:	68 00 10 00 00       	push   $0x1000
80106f1e:	57                   	push   %edi
80106f1f:	50                   	push   %eax
80106f20:	e8 3b d7 ff ff       	call   80104660 <memmove>
80106f25:	58                   	pop    %eax
80106f26:	5a                   	pop    %edx
80106f27:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80106f2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f30:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f33:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f38:	52                   	push   %edx
80106f39:	89 f2                	mov    %esi,%edx
80106f3b:	e8 80 f8 ff ff       	call   801067c0 <mappages>
80106f40:	83 c4 10             	add    $0x10,%esp
80106f43:	85 c0                	test   %eax,%eax
80106f45:	78 3e                	js     80106f85 <copyuvm+0xa5>
80106f47:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f4d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106f50:	76 4e                	jbe    80106fa0 <copyuvm+0xc0>
80106f52:	8b 45 08             	mov    0x8(%ebp),%eax
80106f55:	31 c9                	xor    %ecx,%ecx
80106f57:	89 f2                	mov    %esi,%edx
80106f59:	e8 e2 f7 ff ff       	call   80106740 <walkpgdir>
80106f5e:	85 c0                	test   %eax,%eax
80106f60:	74 5a                	je     80106fbc <copyuvm+0xdc>
80106f62:	8b 18                	mov    (%eax),%ebx
80106f64:	f6 c3 01             	test   $0x1,%bl
80106f67:	74 46                	je     80106faf <copyuvm+0xcf>
80106f69:	89 df                	mov    %ebx,%edi
80106f6b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80106f71:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106f74:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80106f7a:	e8 11 b5 ff ff       	call   80102490 <kalloc>
80106f7f:	85 c0                	test   %eax,%eax
80106f81:	89 c3                	mov    %eax,%ebx
80106f83:	75 8b                	jne    80106f10 <copyuvm+0x30>
80106f85:	83 ec 0c             	sub    $0xc,%esp
80106f88:	ff 75 e0             	pushl  -0x20(%ebp)
80106f8b:	e8 00 fe ff ff       	call   80106d90 <freevm>
80106f90:	83 c4 10             	add    $0x10,%esp
80106f93:	31 c0                	xor    %eax,%eax
80106f95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f98:	5b                   	pop    %ebx
80106f99:	5e                   	pop    %esi
80106f9a:	5f                   	pop    %edi
80106f9b:	5d                   	pop    %ebp
80106f9c:	c3                   	ret    
80106f9d:	8d 76 00             	lea    0x0(%esi),%esi
80106fa0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fa6:	5b                   	pop    %ebx
80106fa7:	5e                   	pop    %esi
80106fa8:	5f                   	pop    %edi
80106fa9:	5d                   	pop    %ebp
80106faa:	c3                   	ret    
80106fab:	31 c0                	xor    %eax,%eax
80106fad:	eb e6                	jmp    80106f95 <copyuvm+0xb5>
80106faf:	83 ec 0c             	sub    $0xc,%esp
80106fb2:	68 f6 7a 10 80       	push   $0x80107af6
80106fb7:	e8 b4 93 ff ff       	call   80100370 <panic>
80106fbc:	83 ec 0c             	sub    $0xc,%esp
80106fbf:	68 dc 7a 10 80       	push   $0x80107adc
80106fc4:	e8 a7 93 ff ff       	call   80100370 <panic>
80106fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fd0 <uva2ka>:
80106fd0:	55                   	push   %ebp
80106fd1:	31 c9                	xor    %ecx,%ecx
80106fd3:	89 e5                	mov    %esp,%ebp
80106fd5:	83 ec 08             	sub    $0x8,%esp
80106fd8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80106fde:	e8 5d f7 ff ff       	call   80106740 <walkpgdir>
80106fe3:	8b 00                	mov    (%eax),%eax
80106fe5:	89 c2                	mov    %eax,%edx
80106fe7:	83 e2 05             	and    $0x5,%edx
80106fea:	83 fa 05             	cmp    $0x5,%edx
80106fed:	75 11                	jne    80107000 <uva2ka+0x30>
80106fef:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ff4:	c9                   	leave  
80106ff5:	05 00 00 00 80       	add    $0x80000000,%eax
80106ffa:	c3                   	ret    
80106ffb:	90                   	nop
80106ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107000:	31 c0                	xor    %eax,%eax
80107002:	c9                   	leave  
80107003:	c3                   	ret    
80107004:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010700a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107010 <copyout>:
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 1c             	sub    $0x1c,%esp
80107019:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010701c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010701f:	8b 7d 10             	mov    0x10(%ebp),%edi
80107022:	85 db                	test   %ebx,%ebx
80107024:	75 40                	jne    80107066 <copyout+0x56>
80107026:	eb 70                	jmp    80107098 <copyout+0x88>
80107028:	90                   	nop
80107029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107030:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107033:	89 f1                	mov    %esi,%ecx
80107035:	29 d1                	sub    %edx,%ecx
80107037:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010703d:	39 d9                	cmp    %ebx,%ecx
8010703f:	0f 47 cb             	cmova  %ebx,%ecx
80107042:	29 f2                	sub    %esi,%edx
80107044:	83 ec 04             	sub    $0x4,%esp
80107047:	01 d0                	add    %edx,%eax
80107049:	51                   	push   %ecx
8010704a:	57                   	push   %edi
8010704b:	50                   	push   %eax
8010704c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010704f:	e8 0c d6 ff ff       	call   80104660 <memmove>
80107054:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107057:	83 c4 10             	add    $0x10,%esp
8010705a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
80107060:	01 cf                	add    %ecx,%edi
80107062:	29 cb                	sub    %ecx,%ebx
80107064:	74 32                	je     80107098 <copyout+0x88>
80107066:	89 d6                	mov    %edx,%esi
80107068:	83 ec 08             	sub    $0x8,%esp
8010706b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010706e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107074:	56                   	push   %esi
80107075:	ff 75 08             	pushl  0x8(%ebp)
80107078:	e8 53 ff ff ff       	call   80106fd0 <uva2ka>
8010707d:	83 c4 10             	add    $0x10,%esp
80107080:	85 c0                	test   %eax,%eax
80107082:	75 ac                	jne    80107030 <copyout+0x20>
80107084:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107087:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010708c:	5b                   	pop    %ebx
8010708d:	5e                   	pop    %esi
8010708e:	5f                   	pop    %edi
8010708f:	5d                   	pop    %ebp
80107090:	c3                   	ret    
80107091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107098:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010709b:	31 c0                	xor    %eax,%eax
8010709d:	5b                   	pop    %ebx
8010709e:	5e                   	pop    %esi
8010709f:	5f                   	pop    %edi
801070a0:	5d                   	pop    %ebp
801070a1:	c3                   	ret    
